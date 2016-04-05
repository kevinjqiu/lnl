CouchBase
=========

Features
--------
- managed cache
- key-value store
- document database
- embedded database
- sync management

Document
--------
- unique id
- value can be JSON document, binary (int, str, bool, compressed text, encrypted values, etc)
- metadata 
    - CAS ("check-and-set-identifier" for conflict management)
    - TTL (for cache invalidation)
    - Flags (other metadata put by client library)
    - Revision #
- document store is a special case of key-value, as everything is layered on top of key-value
- views (distributed secondary index)
- GSI (global secondary index)
- N1QL

Architecture
------------
- Server node includes:
    - Cluster manager (configuration, heartbeat, management interface)
    - Node manager
        * Query service (query planner)
        * Data service (builds and maintains map-reduce views)
        * Index service (builds and maintains GSI)
- Data service and index service has managed cache layer

Sharding (Bucket and vBucket)
-----------------------------
- Bucket is a logical, unique key space
- Think of bucket as couchdb databases
- A bucket has active and replica data sets
- Each data set has 1024 virtual buckets that do not have to be on the same server

Conflict management
-------------------
- Each document has metadata item called 'CAS'
- Usually a unique value
- Scenario:
    - Clent A, B, both getting document D
    - Client B updates D, D has a new CAS value
    - Client A tries to update D
    - CouchBase server checks that the current CAS value is the same as the one sent in
    - CouchBase rejects the update
- Very similar to couchdb's `_rev`

Durability requirements
-----------------------
- Because of managed cache layer, data may not be persisted to disk in the case of crash or failure
- You can increase the durability requirement by:
    - `persistTo` - number of nodes to persist to before returning success to client
    - `replicateTo` - number of nodes to replicate to before success

Querying
--------
- MapReduce views (Distributed Secondary Index)
    - Almost identical semantics to CouchDB map-reduce query
    - Only support javascript (no couch-py equivalent so far)
    - Scatter-and-Gather (querying multiple nodes and gathering results)
- Global Secondary Index
    - New feature aimed for low latency queries without compromising mutation performance
    - Maintained on a dedicated index service node (which can be any node in the cluster)
- N1QL
    - a superset of SQL that handles JSON document manipulation (e.g., NEST, UNNEST)
    - provides a familiar interface to the underlying data (like Hive to Hadoop)
    - query planner enables higher visibility and offers insight into what can be improved
- Querying can be done through REST interface or binary protocol using SDK

Mobile (offline and sync)
-------------------------
Don't want to spend too much time on this

Demo
----
1. Run couchbase docker container
2. Go through setup and show admin interface
3. Run couchdb docker container
4. Run order service server
5. Show `orders/service.py` and `orders/document_manager.py`
6. Keep couchdb document manager, and run `time ./bench.sh`
7. Switch to couchbase document manager, and run `time ./bench.sh`
8. Show the chart in the admin interface
9. open `document_manager` and change `persist_to` to 1
10. Run `time ./bench.sh`
11. Show the chart in the admin interface
12. Show simple N1QL by searching on `orderType`
