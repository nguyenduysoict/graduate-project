import { Component, OnInit, Input, Output, EventEmitter } from '@angular/core';

@Component({
  selector: 'popup-delete',
  templateUrl: './popup-delete.component.html',
  styleUrls: ['./popup-delete.component.css']
})
export class PopupDeleteComponent implements OnInit {

  @Input() title: string = "";
  @Input() visible: boolean = false;
  @Input() content: string = "";
  @Input() delItemID: string = "";

  @Output() confirmDel = new EventEmitter();
  @Output() cancelDel = new EventEmitter();

  constructor() { }
  ngOnInit() {
  }

  onCancel(){
    this.cancelDel.emit(false);
  }

  onConfirm(e){
    this.confirmDel.emit(this.delItemID);
  }

}
