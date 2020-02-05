import { Component, OnInit, EventEmitter, Output, Input } from '@angular/core';

@Component({
  selector: 'app-popup-warning',
  templateUrl: './popup-warning.component.html',
  styleUrls: ['./popup-warning.component.css']
})
export class PopupWarningComponent implements OnInit {

  @Input() title: string = "";
  @Input() visible: boolean = false;
  @Input() content: string = "";

  @Output() closePopup = new EventEmitter();

  constructor() { }
  ngOnInit() {
  }

  onClosePopup(){
    this.closePopup.emit(false);
  }
}
