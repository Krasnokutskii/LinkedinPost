//
//  PersistenceUnderTheHood.swift
//  LinkedinArticles
//
//  Created by Iaroslav Krasnokutskii on 22. 3. 2026..
//

import Foundation


 Persistence under the hood

    SwiftData     |     CoreData     |     Purpose
    .store        | .sqlite          | - store your main data.
    .store-wal    | .sqlite-wal      | - stire data which was written recentrly context.save()
                  |                  |   and not yet saved to store.
    .store-shm    | .sqlite-shm      | - this is indexes to fast search your -wal file.

What happen when item.name accessed ?
→ fault fires
→ search WAL (SHM used internally to index into it)
    → found → return
    → not found → go to .store → return


What happen after context.save()?

→ writes to .store-wal only
→ .store untouched
→ checkpoint happens later (1000 pages / clean close / manual)
    → WAL flushed into .store
    → WAL reset to near zero

Fot better understanding lets brake it ( i mean delete and look what happens)
1. delete -shm, nothing happens, when we relaunch app it generated back just like DerivedData.
2. delete -wal, all your data in the app session is gone, old data still there
3. delete -store, all your data is gone, -wal is invalid
