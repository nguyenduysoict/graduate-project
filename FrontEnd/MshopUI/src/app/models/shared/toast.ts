import { ToastType } from 'src/app/services/common/enumeration/enumeration';


export class Toast {
    Type: ToastType;
    Message: string;
    constructor(type, message){
        this.Type = type;
        this.Message = message;
    }
}