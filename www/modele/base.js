export class DataBase{
    constructor(){
        this.db = null;
    }
    init(){
        this.db = window.sqlitePlugin.openDatabase({name: 'databasestudent.db', location: 'default'});
    }
    createTables(){
        this.db.transaction((tx)=>{
            tx.executeSql(`DROP TABLE IF EXISTS institution`);
        },(error)=>{
            alert("Error: "+error.message)
        },()=>{console.log("successful...")});

        this.db.transaction((tx)=>{
            tx.executeSql(`CREATE TABLE IF NOT EXISTS institution (
                id INTEGER NOT NULL,
                name,
                full_name,
                logo_name)`);
        },(error)=>{
            alert("Error: "+error.message)
        },()=>{console.log("successful...")});
    }
    insertTable(){
        this.db.transaction((tx)=>{
            tx.executeSql("INSERT INTO institution VALUES (?, ?, ?, ?)", [1, "UL", "Université de Lomé", "ul_logo.png"]);
            tx.executeSql("INSERT INTO institution VALUES (?, ?, ?, ?)", [2, "UK", "Université de Kara", "uk_logo.png"]);
            tx.executeSql("INSERT INTO institution VALUES (?, ?, ?, ?)", [3, "UCAO", "Université Catholique de l'Afrique de l'Ouest","ucao_logo.png"]);
            tx.executeSql("INSERT INTO institution VALUES (?, ?, ?, ?)", [4, "IAI", "Institut Africain d'Informatique","iai_logo.png"]);
            tx.executeSql("INSERT INTO institution VALUES (?, ?, ?, ?)", [5, "ESA", "Ecole Supérieur des Affaires", "esa_logo.png"]);
            tx.executeSql("INSERT INTO institution VALUES (?, ?, ?, ?)", [6, "ENAM", "Ecole Nationale des Assistants Médicaux", "enam_logo.png"]);
            tx.executeSql("INSERT INTO institution VALUES (?, ?, ?, ?)", [7, "ESGIS", "Ecole Supérieur de Gestion d'Informatique et des Sciences", "esgis_logo.jpeg"]);
        },(error)=>{
            alert("Error: "+error.message)
        },()=>{console.log("successful...")});
    }
    selectTable(resolve){
        this.db.transaction((tx)=>{
            tx.executeSql("SELECT * FROM institution", [], (tx, res)=>{
                resolve(res.rows);
            });
        },(error)=>{
            alert("Query error: "+error.message)
            return error.message
        },()=>{console.log("successful...")
                return "OK..."});
    }
    
    
}