import { Injectable } from '@angular/core';
import { BaseService } from '../base-service/base.service';
import { HttpClient } from '@angular/common/http';
import { ServerResponse } from 'src/app/models/shared/server-response';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class StaffService extends BaseService {
  controller = "Staff";
  constructor(public http: HttpClient) { super(http); }

  getSalaryByStaffCode(staffCode): Observable<ServerResponse>{
    return this.http.get<ServerResponse>(this.url+this.controller+"/salary/"+staffCode);
  }
  
  
}
