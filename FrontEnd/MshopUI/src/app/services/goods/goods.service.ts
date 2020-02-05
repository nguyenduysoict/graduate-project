import { Injectable } from '@angular/core';
import { BaseService } from '../base-service/base.service';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class GoodsService extends BaseService {

  controller="Item";
  constructor(public http:HttpClient) {super(http); }
}
