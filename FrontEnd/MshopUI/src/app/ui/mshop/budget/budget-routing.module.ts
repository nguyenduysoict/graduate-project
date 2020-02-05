import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { BudgetComponent } from './budget.component';
import { IncomeComponent } from './income/income.component';


const routes: Routes = [
  {path: '', component: BudgetComponent, 
    children: [
      { path: 'thu-chi', component: IncomeComponent },
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class BudgetRoutingModule { }
