/*
Generate mock data for testing the Caliber sync class
*/
global class SyncCalloutMock implements HttpCalloutMock {

    global HttpResponse respond(HttpRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setStatusCode(200);
        if (req.getEndpoint().contains('/batch') ) {
            res.setBody('[{ "id": 48,' +
                    '"batchId": "TR-1077",' +
                    '"name": "Mock Batch 48",' +
                    '"startDate": "2016-07-29",' +
                    '"endDate": "2016-10-07",' +
                    '"skill": "Big Data",' +
                    '"location": "New York",' +
                    '"type": "Corporate",' +
                    '"goodGrade": 70,' +
                    '"passingGrade": 80,' +
                    '"employeeAssignments": [],' +
                '"currentWeek": 11},' +
                '{"id": 469,' +
                    '"batchId": "TR-1714",' +
                    '"name": "Mock Batch 469",' +
                    '"startDate": "2020-09-16",' +
                    '"endDate": "2020-11-25",' +
                    '"skill": "Java/Microservices",' +
                    '"location": "West Virginia",' +
                    '"type": "Corporate",' +
                    '"goodGrade": 70,' +
                    '"passingGrade": 80,' +
                '"currentWeek": 11}]'
                );
        } else {
            res.setBody('[{ "email": "mock15.associate7e28dcdf-8ce7-40bc-8b75-12a0ba305009@mock.com",' + 
                        '"salesforceId": "SF-1840","firstName": "Mock 15","lastName": "Associate 15",' + 
                        '"flag": null},{"email": "mock12.associate46353ee8-34ab-4ac5-a0c0-c781590da3f7@mock.com",' +
                        '"salesforceId": "SF-1837","firstName": "Mock 12","lastName": "Associate 12","flag": null}]');
        }
        return res;
    }
}
