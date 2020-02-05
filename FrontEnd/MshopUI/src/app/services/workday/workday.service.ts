import { Injectable } from '@angular/core';
import { BaseService } from '../base-service/base.service';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class WorkdayService extends BaseService{
  controller = "Workday";
  constructor(private http: HttpClient) {super(http) }
}
