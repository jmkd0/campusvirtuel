import {DataBase} from '../modele/base.js'; 
import {Institution} from './institution.js'
export class Controller{
    constructor(){
        this.base = null;
    }
    init(){
        this.base = new DataBase()
        this.base.init();
        this.base.createTables();
        this.base.insertTable();
    }
    getInstitution(done){
        let promise = new Promise((resolveBase, reject)=>{
            this.base.selectTable(resolveBase); 
        });
        promise.then((response)=>{
            let institutions = [];
            for(let i=0; i<response.length; i++){
                let institution = new Institution();
                institution.setName(response.item(i).name);
                institution.setFullName(response.item(i).full_name);
                institution.setLogoName(response.item(i).logo_name);
                institutions.push(institution);
            }
            done(institutions);
        });
               
    }

}