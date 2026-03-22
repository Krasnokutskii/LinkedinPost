# Persistence under the hood

    SwiftData     |     CoreData     |     Purpose
    .store        | .sqlite          | - stores your main data.
    .store-wal    | .sqlite-wal      | - stores data written recently via context.save()
                  |                  |   and not yet flushed to .store.
    .store-shm    | .sqlite-shm      | - index for fast search inside the -wal file.

## What happens when item.name is accessed?
→ fault fires
→ search WAL (SHM used internally to index into it)
    → found → return
    → not found → go to .store → return

## What happens after context.save()?

→ writes to .store-wal only
→ .store untouched
→ checkpoint happens later (1000 pages / clean close / manual)
    → WAL flushed into .store
    → WAL reset to near zero

## For better understanding, let's break it (delete and see what happens)
1. delete .shm → nothing happens, regenerated on next launch (like DerivedData)
2. delete .wal → any writes since last checkpoint are lost, data already in .store is safe
3. delete .store → all persisted data is gone, .wal without .store is useless

## Bonus: data looks missing in DB Browser?
→ you probably opened .store without the -wal beside it
→ always copy all 3 files together
→ DB Browser reads WAL automatically if it sits next to .store
