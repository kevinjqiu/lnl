# MySQL demystified
## How does MySQL execute queries?
* SQL => Parse Tree => Execution plan
* The execution plan is a data structure, not byte-code
* The executor makes storage engine calls

## Execution plan
"Deep left tree" -- always

## Explain output columns
* `id`
* `select_type`
* `table`
* `possible_keys`

### id
* which `SELECT` the row belongs to
* Labelled sequentially
* complex select:
    * subquery: numbered according to the position in SQL text
    * derived: executed as a temporary table
    * union: fill a temp table, then read out with a `NULL` id

### select_type
* simple: there's only one `SELECT` in the whole query, `select_type` is `PRIMARY`
* complex:
    * subquery: numbered according to the position in SQL text
    * derived: executed as a temporary table
    * union: fill a temp table, then read out with a `NULL` id

### table
* table name or alias
* `<DerivedN>`, `N` correspond to `id`
* `<unionM,N>`, `M`, `N` correspond to `id`

### type
* describes how MySQL will access the rows
* Possible values:
    * ALL: table scan
    * index: full index scan
    * range: range of an index
    * ref: value as a reference to look into an index if rows in the index match the value
    * eq_ref: like `ref` but unique (unique index or PK)
    * const
    * system: does not require accessing a table, e.g., `MAX(col)`
    * NULL: no table involved, e.g., `SELECT 1`

### Index-related columns (possible_kes, key, key_len)
* possible_keys: which indexes were considered?
* key: which indexes did the optimizer choose?
* key_len: how many bytes of the index will be used? if key_len less than the index (e.g., compound index), that means MySQL didn't use the whole index


### ref
* The source of values used for lookups
* `const`
* `NULL` means not looking for a particular value for that table

### rows
* Estimated rows to examine in the table/index

### extra
* Using index
    * If the query only involve columns that are in the index, MySQL can query directly against the index, without looking at the table at all
    * Hitting a index (`type`) does not necessarily mean `Using index`.  If not `Using index`, MySQL got the indexed value but still has to go back and look it up in the table for other columns, which may result in lots of random IO (slow)
* Using where
    * Post-filter using the where clause
* Using temporary
    * The query is going to create an implicit temporary table
* Using filesort
    * Sorting in memory, if it doesn't fit, then write to file
    * Algorithm is quick sort
