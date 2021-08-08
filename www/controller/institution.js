export class Institution{
    constructor(){
        this.id = null;
        this.name = null;
        this.full_name = null;
        this.logo_name = null;
        this.is_in_local = false;
    }
    /* ID */
    setId(id){
        this.id = id;
    }
    getId(){
        return this.id;
    }
    /* Name */
    setName(name){
        this.name = name;
    }
    getName(){
        return this.name;
    }
    /* Full Name */
    setFullName(full_name){
        this.full_name = full_name;
    }
    getFullName(){
        return this.full_name;
    }
    /* Logo Path */
    setLogoName(logo_name){
        this.logo_name = logo_name;
    }
    getLogoName(){
        return this.logo_name;
    }
    /* Is In Local */
    setInLocal(is_in_local){
        this.is_in_local = is_in_local;
    }
    getInLocal(){
        return this.is_in_local;
    }
}