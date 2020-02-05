import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { ServerResponse } from 'src/app/models/shared/server-response';

@Injectable({
  providedIn: 'root'
})
export class AccountService {
  url = "http://localhost:50740/api/account/";
  constructor(private http:HttpClient) { }


  login(obj): Observable<ServerResponse>{
    return this.http.post<ServerResponse>(this.url+"login", obj);
  }

  logout(obj): Observable<ServerResponse>{
    return this.http.post<ServerResponse>(this.url+"logout", obj);
  }

}
