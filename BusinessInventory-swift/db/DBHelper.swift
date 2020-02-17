//
//  DBHelper.swift
//  BusinessInventory-swift
//
//  Created by Marcelo Agudelo on 2020-02-12.
//  Copyright © 2020 Marcelo Agudelo. All rights reserved.
//

import Foundation

class DBHelper {
    
    init() {
        db = openDatabase()
        createTableProduct()
    }
    
    let dbPath: String = "myDb.sqlite"
    var db:OpaquePointer?
    
    func openDatabase() -> OpaquePointer? {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if (sqlite3_open(fileURL.path, &db) != SQLITE_OK){
            print("error opening database")
            return nil
        } else {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    
    func createTableProduct() {
        var createTableString = "CREATE TABLE IF NOT EXISTS product ("
        createTableString += "Id INTEGER PRIMARY KEY AUTOINCREMENT, "
        createTableString += "name_inventory TEXT, "
        createTableString += "place TEXT, "
        createTableString += "description TEXT, "
        createTableString += "type TEXT, "
        createTableString += "date_product TEXT, "
        createTableString += "barcode TEXT, "
        createTableString += "bought_no REAL, "
        createTableString += "sold_no REAL, "
        createTableString += "unid_buy_price_us INTEGER, "
        createTableString += "unid_sell_price_us INTEGER, "
        createTableString += "total_cost_us REAL, "
        createTableString += "total_received_us INTEGER, "
        createTableString += "total_profit_us INTEGER, "
        createTableString += "photo TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if (sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK) {
            if (sqlite3_step(createTableStatement) == SQLITE_DONE) {
                print("product table created.")
            } else {
                print("product table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    func insertProduct(product: Product) {
        var insertStatementString = "INSERT INTO product (name_inventory, place, "
        insertStatementString += "description, type, date_product, "
        insertStatementString += "barcode, bought_no, sold_no, "
        insertStatementString += "unid_buy_price_us, unid_sell_price_us, total_cost_us, "
        insertStatementString += "total_received_us, total_profit_us, photo) VALUES (?,?,"
        insertStatementString += "?,?,?,"
        insertStatementString += "?,?,?,"
        insertStatementString += "?,?,?,"
        insertStatementString += "?,?,?)"
        var insertStatement: OpaquePointer? = nil
        if (sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK) {
            sqlite3_bind_text(insertStatement, 1, (product.nameInventory as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (product.place as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (product.description as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (product.type as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (product.dateProduct as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 6, (product.barcode as NSString).utf8String, -1, nil)
            sqlite3_bind_double(insertStatement, 7, Double(product.boughtNo))
            sqlite3_bind_double(insertStatement, 8, Double(product.soldNo))
            sqlite3_bind_int(insertStatement, 9, Int32(product.unidBuyPriceUS))
            sqlite3_bind_int(insertStatement, 10, Int32(product.unidSellPriceUS))
            sqlite3_bind_double(insertStatement, 11, Double(product.totalCostUS))
            sqlite3_bind_int(insertStatement, 12, Int32(product.totalReceivedUS))
            sqlite3_bind_int(insertStatement, 13, Int32(product.totalProfitUS))
            sqlite3_bind_text(insertStatement, 14, (product.photo as NSString).utf8String, -1, nil)
            
            if (sqlite3_step(insertStatement) == SQLITE_DONE) {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func readProduct() -> [Product] {
        let queryStatementString = "SELECT * FROM product"
        var queryStatement: OpaquePointer? = nil
        var psns : [Product] = []
        if (sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK) {
            while (sqlite3_step(queryStatement) == SQLITE_ROW) {
                let id = sqlite3_column_int(queryStatement, 0)
                let nameInventory = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let place = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let description = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let type = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                let dateProduct = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                let barcode = String(describing: String(cString: sqlite3_column_text(queryStatement, 6)))
                let boughtNo = sqlite3_column_double(queryStatement, 7)
                let soldNo = sqlite3_column_double(queryStatement, 8)
                let unidBuyPriceUs = sqlite3_column_int(queryStatement, 9)
                let unidSellPriceUs = sqlite3_column_int(queryStatement, 10)
                let totalCostUs = sqlite3_column_double(queryStatement, 11)
                let totalReceivedUs = sqlite3_column_int(queryStatement, 12)
                let totalProfitUs = sqlite3_column_int(queryStatement, 13)
                let photo = String(describing: String(cString: sqlite3_column_text(queryStatement, 14)))
                
                psns.append(Product(id: Int(id), nameInventory: nameInventory, place: place, description: description, type: type, dateProduct: dateProduct, barcode: barcode, boughtNo: boughtNo, soldNo: soldNo, unidBuyPriceUS: Int(unidBuyPriceUs), unidSellPriceUS: Int(unidSellPriceUs), totalCostUS: totalCostUs, totalReceivedUS: Int(totalReceivedUs), totalProfitUS: Int(totalProfitUs), photo: photo ))
                print("Query Result:")
                print("\(id) | \(nameInventory) | \(place) | \(description) | \(type) | \(dateProduct) | \(barcode) | \(boughtNo) | \(soldNo) | \(unidBuyPriceUs) | \(unidSellPriceUs) | \(totalCostUs) | \(totalReceivedUs) | \(totalProfitUs) | \(photo)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }
    
    func deleteProductByID(id:Int) {
        let deleteStatementStirng = "DELETE FROM product WHERE Id = ?"
        var deleteStatement: OpaquePointer? = nil
        if (sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK) {
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            if (sqlite3_step(deleteStatement) == SQLITE_DONE) {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
    
}
