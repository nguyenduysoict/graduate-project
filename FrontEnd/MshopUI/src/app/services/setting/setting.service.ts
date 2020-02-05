import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { BaseService } from '../base-service/base.service';

@Injectable({
  providedIn: 'root'
})
export class SettingService extends BaseService {

  controller="Setting";
  constructor(private http:HttpClient) {super(http) }
}
