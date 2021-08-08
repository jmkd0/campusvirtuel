/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

// Wait for the deviceready event before using any of Cordova's device APIs.
// See https://cordova.apache.org/docs/en/latest/cordova/events/events.html#deviceready
document.addEventListener('deviceready', onDeviceReady, false);

function onDeviceReady() {
    // Cordova is now initialized. Have fun!
    let buttonDocument = document.getElementById("open_doc");
    buttonDocument.addEventListener('click', openDocument);

    let buttonData = document.getElementById("send_data");
    buttonData.addEventListener('click', getRemoteData);

    let buttonLocalRequest = document.getElementById("request_data");
    buttonLocalRequest.addEventListener('click', getLocalData);

    let goToInstitution = document.getElementById("institution");
    goToInstitution.addEventListener('click', ()=>{
        window.open("institution.html", '_self')
    });
}
function getLocalData(){
    let dataContainer = document.getElementById("local_data_container");
    let db  = null
    let dataBase = {
        init: function(){
            db = window.sqlitePlugin.openDatabase({name: 'databasestudent.db', location: 'default'});
        },
        createTable: function(){
            db.transaction((tx)=>{
                tx.executeSql("CREATE TABLE IF NOT EXISTS institution (name, full_name)");
            },(error)=>{
                alert("Error: "+error.message)
            },()=>{console.log("successful...")});
        },
        insertTable: function(){
            db.transaction((tx)=>{
                tx.executeSql("INSERT INTO institution VALUES (?, ?)", ["UL", "Université de Lomé"]);
                tx.executeSql("INSERT INTO institution VALUES (?, ?)", ["UK", "Université de Kara"]);
                tx.executeSql("INSERT INTO institution VALUES (?, ?)", ["ESA", "Ecole Supérieur des Affaires"]);
            },(error)=>{
                alert("Error: "+error.message)
            },()=>{console.log("successful...")});
        },
        selectTable: function(){
            db.transaction((tx)=>{
                tx.executeSql("SELECT * FROM institution", [], (tx, res)=>{
                    let info = "There are: "+res.rows.item(0).name+" and "+res.rows.item(0).full_name
                    alert(info)
                    dataContainer.innerHTML = info
                });
            },(error)=>{
                alert("Query error: "+error.message)
            },()=>{console.log("successful...")});
        }
    }
    dataBase.init()
    dataBase.createTable()
    dataBase.insertTable()
    dataBase.selectTable()
}

function getRemoteData(){
    
    let dataContainer = document.getElementById("remote_data_container");
    //let url = 'http://192.168.0.23:3000/request_native'
    let url = 'https://jsonplaceholder.typicode.com/posts'
    let request_data = {
        parents:  ['1'],   
        table: 'structure'
    };
    cordova.plugin.http.post(url, request_data, {}, function(response) {
        let data =  JSON.parse(response.data)
        alert(JSON.stringify(data))
        dataContainer.innerHTML = JSON.stringify(data)
        /*dataContainer.innerHTML = "data: "+data[0].full_name; */
    }, function(error) {
        alert(JSON.stringify(error))
        console.log(error);
    });

}

function openDocument(){
    let url1 = "https://d1fmx1rbmqrxrr.cloudfront.net/cnet/optim/i/edit/2019/04/eso1644bsmall__w770.jpg";
    let url2 = 'http://licence-math.univ-lyon1.fr/lib/exe/fetch.php?media=exomaths:exercices_corriges_espaces_vectoriels.pdf';
    let androidVersion = parseInt(device.version);
    let path_doc = "../documents"
    let docContainer = document.getElementById("doc_container");
    let butt = document.createElement("ion-button");
    butt.innerHTML = 'buttton'

    const bookOptions = {requestHeaders: { "Accept": "text/xml" } };
    alert("jean")
    var Book = ePub('../documents/physique.epub');
    alert(Book)
     Book.renderTo(docContainer, {
        flow: "scrolled-doc", // For generic books
        method: "continuous", // For generic books
        width: "100%",
        heigh: "90%"
     });//div id
     alert("go")
     Book.rendition.display()
     alert("ak")
     docContainer.appendChild(butt)
    /* let dir = cordova.file.applicationDirectory;
    console.log(dir)
    let frame = document.getElementById("id_frame");
    frame.src = dir+"www/documents/math.pdf" */
    
    
    /* let fileTransfer = new FileTransfer();
    fileTransfer.download(url1, path+"/image.jpg", function(entry){
        console.log("Download success")
    },
    function(error){
        console.log(error.source+"____"+error.target+"___"+error.code)
    }); */
    
    //let fileOpener = new FileOpener();
    /* let fileOpener = new FileOpener();
    fileOpener.open('../documents/math.pdf', 'application/pdf')
    .then(() => console.log('File is opened'))
    .catch(e => console.log('Error opening file', e));  */
}