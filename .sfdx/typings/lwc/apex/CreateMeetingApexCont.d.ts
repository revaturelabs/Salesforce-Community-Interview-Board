declare module "@salesforce/apex/CreateMeetingApexCont.getAll" {
  export default function getAll(): Promise<any>;
}
declare module "@salesforce/apex/CreateMeetingApexCont.getBatches" {
  export default function getBatches(): Promise<any>;
}
declare module "@salesforce/apex/CreateMeetingApexCont.getAssociates" {
  export default function getAssociates(): Promise<any>;
}
declare module "@salesforce/apex/CreateMeetingApexCont.getClients" {
  export default function getClients(): Promise<any>;
}
declare module "@salesforce/apex/CreateMeetingApexCont.createMeeting" {
  export default function createMeeting(param: {meeting: any, strInterviewer: any, strAssociate: any}): Promise<any>;
}
declare module "@salesforce/apex/CreateMeetingApexCont.createMeetingAllBatch" {
  export default function createMeetingAllBatch(param: {meeting: any, strInterviewer: any, fullBatch: any}): Promise<any>;
}
