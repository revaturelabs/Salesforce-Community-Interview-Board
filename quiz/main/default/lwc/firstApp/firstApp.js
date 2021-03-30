import { LightningElement } from 'lwc';

export default class FirstApp extends LightningElement {

    sessionId;
    state = 'list';

    handleNavigate(event) {
        this.state = event.detail.state;
        this.sessionId = event.detail.sessionId;
      }

      get isStateList() {
        return this.state === 'list';
      }
      get isStateDetails() {
        return this.state === 'details';
      }

}