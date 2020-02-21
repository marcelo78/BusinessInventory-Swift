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
    
    func insertProduct(product: ProductEntity) {
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
    
    func readProduct() -> [ProductEntity] {
        let queryStatementString = "SELECT * FROM product ORDER BY 2 ASC"
        var queryStatement: OpaquePointer? = nil
        var psns: [ProductEntity] = []
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
                
                psns.append(ProductEntity(id: Int(id), nameInventory: nameInventory, place: place, description: description, type: type, dateProduct: dateProduct, barcode: barcode, boughtNo: boughtNo, soldNo: soldNo, unidBuyPriceUS: Int(unidBuyPriceUs), unidSellPriceUS: Int(unidSellPriceUs), totalCostUS: totalCostUs, totalReceivedUS: Int(totalReceivedUs), totalProfitUS: Int(totalProfitUs), photo: photo ))
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
    
    func getProduct(idItem: Int) -> ProductEntity {
        let queryStatementString = "SELECT * FROM product WHERE Id = ?"
        var queryStatement: OpaquePointer? = nil
        var psns = ProductEntity()
        if (sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK) {
            sqlite3_bind_int(queryStatement, 1, Int32(idItem))
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
                
                psns = ProductEntity(id: Int(id), nameInventory: nameInventory, place: place, description: description, type: type, dateProduct: dateProduct, barcode: barcode, boughtNo: boughtNo, soldNo: soldNo, unidBuyPriceUS: Int(unidBuyPriceUs), unidSellPriceUS: Int(unidSellPriceUs), totalCostUS: totalCostUs, totalReceivedUS: Int(totalReceivedUs), totalProfitUS: Int(totalProfitUs), photo: photo )
                print("Query Result:")
                print("\(id) | \(nameInventory) | \(place) | \(description) | \(type) | \(dateProduct) | \(barcode) | \(boughtNo) | \(soldNo) | \(unidBuyPriceUs) | \(unidSellPriceUs) | \(totalCostUs) | \(totalReceivedUs) | \(totalProfitUs) | \(photo)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }
    
    func updateProduct(product: ProductEntity) {
        var updateStatementString = "UPDATE product SET name_inventory = ?, place = ?, "
        updateStatementString += "description = ?, type = ?, date_product = ?, "
        updateStatementString += "barcode = ?, bought_no = ?, sold_no = ?, "
        updateStatementString += "unid_buy_price_us = ?, unid_sell_price_us = ?, total_cost_us = ?, "
        updateStatementString += "total_received_us = ?, total_profit_us = ?, photo = ? "
        updateStatementString += "WHERE Id = ?"
        var updateStatement: OpaquePointer? = nil
        if (sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK) {
            sqlite3_bind_text(updateStatement, 1, (product.nameInventory as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 2, (product.place as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 3, (product.description as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 4, (product.type as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 5, (product.dateProduct as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 6, (product.barcode as NSString).utf8String, -1, nil)
            sqlite3_bind_double(updateStatement, 7, Double(product.boughtNo))
            sqlite3_bind_double(updateStatement, 8, Double(product.soldNo))
            sqlite3_bind_int(updateStatement, 9, Int32(product.unidBuyPriceUS))
            sqlite3_bind_int(updateStatement, 10, Int32(product.unidSellPriceUS))
            sqlite3_bind_double(updateStatement, 11, Double(product.totalCostUS))
            sqlite3_bind_int(updateStatement, 12, Int32(product.totalReceivedUS))
            sqlite3_bind_int(updateStatement, 13, Int32(product.totalProfitUS))
            sqlite3_bind_text(updateStatement, 14, (product.photo as NSString).utf8String, -1, nil)
            sqlite3_bind_int(updateStatement, 15, Int32(product.id))
            if (sqlite3_step(updateStatement) == SQLITE_DONE) {
                print("Successfully update row.")
            } else {
                print("Could not update row.")
            }
        } else {
            print("UPDATE statement could not be prepared.")
        }
        sqlite3_finalize(updateStatement)
    }

    func getSummary() -> SummaryEntity {
        var queryStatementString = "SELECT SUM((bought_no - sold_no) * unid_buy_price_us) data1, "
        queryStatementString += "SUM(CASE WHEN bought_no = sold_no THEN bought_no ELSE (bought_no - sold_no) END) data2, "
        queryStatementString += "SUM(CASE WHEN bought_no = sold_no THEN 0 ELSE (sold_no) END) data3, "
        queryStatementString += "ROUND(SUM(total_profit_us), 2) data4, "
        queryStatementString += "ROUND(SUM(total_cost_us), 2) data5, "
        queryStatementString += "ROUND(SUM(sold_no * unid_sell_price_us), 2) data6 "
        queryStatementString += "FROM product"
        var queryStatement: OpaquePointer? = nil
        var psns = SummaryEntity()
        if (sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK) {
            while (sqlite3_step(queryStatement) == SQLITE_ROW) {
                let data1 = sqlite3_column_double(queryStatement, 0)
                let data2 = sqlite3_column_double(queryStatement, 1)
                let data3 = sqlite3_column_double(queryStatement, 2)
                let data4 = sqlite3_column_double(queryStatement, 3)
                let data5 = sqlite3_column_double(queryStatement, 4)
                let data6 = sqlite3_column_double(queryStatement, 5)

                psns = SummaryEntity(data1: data1, data2: data2, data3: data3, data4: data4, data5: data5, data6: data6)
                print("Query Result:")
                print("\(data1) | \(data2) | \(data3) | \(data4) | \(data5) | \(data6)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }

}
