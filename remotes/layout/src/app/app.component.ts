import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { CoreComponent } from 'core';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet, CoreComponent],
  templateUrl: './app.component.html',
  styleUrl: './app.component.scss'
})
export class AppComponent {
  title = 'layout';
}
