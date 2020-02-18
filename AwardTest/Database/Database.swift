//
//  Database.swift
//  AwardTest
//
//  Created by Nico Prasasty S on 18/02/20.
//  Copyright © 2020 Nico Prasasty Sembiring. All rights reserved.
//

import UIKit

class Database {
    static let shared = Database()
    let fileManager = FileManager()
    var sqliteDB: OpaquePointer? = nil
    var dbURL: URL?
    
    func runDB(){
        createDBFile()
        createTable()
    }
    
    fileprivate func createDBFile(){
        do{
            let baseURL = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            dbURL = baseURL.appendingPathComponent("award.sqlite")
            print("dbURL:\n\(dbURL!)")
        }catch{
            print(error)
        }
    }
    
    fileprivate func createTable(){
        let flag = SQLITE_OPEN_CREATE | SQLITE_OPEN_READWRITE
        let status = sqlite3_open_v2(String(utf8String: dbURL!.absoluteString), &sqliteDB, flag, nil)
        
        if status == SQLITE_OK{
            let error: UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>! = nil
            
            let sqlStatement = [
            "create table if not exists dt_filter (Filter Text);"
            ]
            
            sqlStatement.forEach { (statement) in
                if sqlite3_exec(sqliteDB, statement, nil, nil, error) == SQLITE_OK{
                    print("Create OK")
                }else{
                    print("failed to create:\n\(statement)")
                }
            }
            
        }
    }
    
    func insertDB(query: String){
        
        var insertStatement: OpaquePointer? = nil
        sqlite3_prepare_v2(sqliteDB, query, -1, &insertStatement, nil)
        if sqlite3_step(insertStatement) == SQLITE_DONE{
            print("inserted")
        }else{
            print("not inserted:\(query)")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func selectedDB(query: String) -> [String]{
        var selectedStatement: OpaquePointer? = nil
        var columnValue = [String]()
        if sqlite3_prepare_v2(sqliteDB, query, -1, &selectedStatement, nil) == SQLITE_OK{
            while sqlite3_step(selectedStatement) == SQLITE_ROW {
                let value = String(cString: sqlite3_column_text(selectedStatement, 0))
                columnValue.append(value)
            }
        }
        sqlite3_finalize(selectedStatement)
        print(columnValue)
        return columnValue
    }
    
//    func selectedDB(query: String) -> [[String]]{
//        var selectedStatement: OpaquePointer? = nil
//        var columnValue = [[String]]()
//        if sqlite3_prepare_v2(sqliteDB, query, -1, &selectedStatement, nil) == SQLITE_OK{
//            while sqlite3_step(selectedStatement) == SQLITE_ROW {
//                var rowValue = [String]()
//                for i in 0..<sqlite3_column_count(selectedStatement){
//                    let value = String(cString: sqlite3_column_text(selectedStatement, i))
//                    rowValue.append(value)
//                }
//                columnValue.append(rowValue)
//            }
//        }
//        sqlite3_finalize(selectedStatement)
//        print(columnValue)
//        return columnValue
//    }
    
    func deletedDB(tableName: String){
        var deletedStatement: OpaquePointer? = nil
        let deletedSQLStatement = "delete from \(tableName);"
        sqlite3_prepare_v2(sqliteDB, deletedSQLStatement, -1, &deletedStatement, nil)
        if sqlite3_step(deletedStatement) == SQLITE_DONE{
            print("deleted")
        }else{
            print("not deleted")
        }
        sqlite3_finalize(deletedStatement)
    }
}
