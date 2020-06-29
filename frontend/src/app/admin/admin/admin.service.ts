import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Injectable()
export class AdminService {
  constructor(private httpClient: HttpClient) {

  }
  async send() {
    await this.httpClient.get('/api/admin').toPromise();
  }
}
