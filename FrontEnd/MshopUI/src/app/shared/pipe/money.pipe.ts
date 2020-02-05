import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'money'
})
export class MoneyPipe implements PipeTransform {

  transform(value: number): any {
    if(value){
      return value.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1.')
    }
  }

}
