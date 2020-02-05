import { Injectable, Query } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import { ServerResponse } from 'src/app/models/shared/server-response';
import { QueryCondition } from 'src/app/models/shared/query-condition';

@Injectable({
  providedIn: 'root'
})
export class BaseService {

  controller = "";
  url = "http://localhost:50740/api/";
  // headers = new HttpHeaders({'Content-Type':'application/json; charset=utf-8'});
  headers = new HttpHeaders({'Content-Type':'multipart/form-data'});
  constructor(private httpClient: HttpClient) { }


  getAll(): Observable<ServerResponse>{
    return this.httpClient.get<ServerResponse>(this.url+this.controller);
  }

  getByID(id): Observable<ServerResponse>{
    return this.httpClient.get<ServerResponse>(this.url+this.controller+"/"+id);
  }

  getDataByQueryCondition(queryCondition): Observable<ServerResponse>{
    return this.httpClient.post<ServerResponse>(this.url+this.controller+"/getByCondition", queryCondition);
  }


  getDataByShop(id): Observable<ServerResponse>{
    return this.httpClient.get<ServerResponse>(this.url+this.controller+"/getByShop/"+id);
  }

  getByFieldName(id): Observable<ServerResponse>{
    return this.httpClient.get<ServerResponse>(this.url+this.controller+"/getDetail/"+id);
  }


  getNo(): Observable<ServerResponse>{
    return this.httpClient.get<ServerResponse>(this.url+this.controller+"/no");
  }

 
  save(obj): Observable<ServerResponse>{
    return this.httpClient.post<ServerResponse>(this.url+this.controller, obj);
  }

  upload(obj:FormData): Observable<ServerResponse>{
    return this.httpClient.post<ServerResponse>(this.url+"upload", obj);
  }

  update(obj): Observable<ServerResponse>{
    return this.httpClient.put<ServerResponse>(this.url+this.controller, obj);
  }

  delete(id):Observable<ServerResponse>{
    return this.httpClient.delete<ServerResponse>(this.url+this.controller+"/"+id);
  }
}
