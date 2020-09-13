import { LightningElement, api, wire, track } from 'lwc';
import { getPicklistValues, getObjectInfo } from 'lightning/uiObjectInfoApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import setSessionQuestions from '@salesforce/apex/QuizEditorController.setSessionQuestions';
import getSessionQuestionIds from '@salesforce/apex/QuizEditorController.getSessionQuestionIds';
import getAllQuestions from '@salesforce/apex/QuizEditorController.getAllQuestions';
import QUESTION_OBJECT from '@salesforce/schema/Quiz_Question__c';
import QUESTION_STACK from '@salesforce/schema/Quiz_Question__c.Stack__c';

export default class QuestionPicker extends LightningElement {
    @api recordId;
    @track pickListvalues;
    @track values;
    @track error;
    @track recordtypeidqstn;
    @track stackChoice;

    allQuestions = [];
    selectedQuestionIds = [];
    isSaving = false;
    isDirty = false;

    @wire(getObjectInfo, {
        objectApiName : QUESTION_OBJECT
    })
    getObjectdata({ data, error }){
        if(data){
            this.recordtypeidqstn = data.defaultRecordTypeId;
        }
        else if(error) {
            this.error =  error;
        }
    }

    @wire(getPicklistValues, {
        recordTypeId : '$recordtypeidqstn',
        fieldApiName : QUESTION_STACK
    })
    wiredPickListValue({ data, error }){
        if(data){
            this.pickListvalues = data.values;
            this.error = undefined;
        }
        if(error){
            console.log(` Error while fetching Picklist values  ${error}`);
            this.error = error;
            this.pickListvalues = undefined;
        }
    }


    @wire(getAllQuestions, {
        stack : '$stackChoice'
    })
    getAllQuestions({ data, error }) {
        if (data) {
            this.allQuestions = data.map((question) => ({
                value: question.id,
                label: question.label
            }));
        } else if (error) {
            console.error(error);
            this.showToast('Failed to load all questions', undefined, 'error');
        }
    }

    @wire(getSessionQuestionIds, { sessionId: '$recordId' })
    getSessionQuestionIds({ data, error }) {
        if (data) {
            this.selectedQuestionIds = data;
        } else if (error) {
            console.error(error);
            this.showToast(
                'Failed to load session questions',
                undefined,
                'error'
            );
        }
    }

    handleQuestionChange(event) {
        this.selectedQuestionIds = event.detail.value;
        this.isDirty = true;
    }

    handleSaveClick() {
        this.isSaving = true;
        setSessionQuestions({
            sessionId: this.recordId,
            questionIds: this.selectedQuestionIds
        })
            .then(() => {
                this.isSaving = false;
                this.isDirty = false;
                this.showToast('Success', 'Session questions saved', 'success');
            })
            .catch((error) => {
                console.error(error);
                this.showToast(
                    'Failed to save session questions',
                    undefined,
                    'error'
                );
            });
    }

    handleRandomizeClick() {
        // Prompt number of questions
        // eslint-disable-next-line no-alert
        const input = prompt(
            'Enter the number of questions you would like to select',
            '5'
        );
        const totalQuestionCount = this.allQuestions.length;
        const selectionCount = parseInt(input, 10);
        if (
            isNaN(selectionCount) ||
            selectionCount < 1 ||
            selectionCount > totalQuestionCount
        ) {
            this.showToast(
                'Operation aborted',
                'Invalid question count',
                'info'
            );
            return;
        }
        // Select random questions
        const selectedIds = [];
        const allQuestions = JSON.parse(JSON.stringify(this.allQuestions));
        for (let i = 0; i < selectionCount; i++) {
            const index = Math.floor(Math.random() * allQuestions.length);
            const question = allQuestions.splice(index, 1)[0];
            selectedIds.push(question.value);
        }
        // Save selection
        this.selectedQuestionIds = selectedIds;
        this.isDirty = true;
        // Notify user
        this.showToast(
            'Success',
            `${selectionCount} random questions selected. Don't forget to save them.`,
            'success'
        );
    }

    showToast(title, message, variant) {
        this.dispatchEvent(
            new ShowToastEvent({
                title,
                message,
                variant
            })
        );
    }

    handleChange(event) {
        this.stackChoice = event.detail.value;
        console.log(this.stackChoice);
    }

    get isLoading() {
        return (
            this.isSaving || !(this.allQuestions && this.selectedQuestionIds)
        );
    }

    get cardTitle() {
        return `Session Questions ${this.isDirty ? '(modified)' : ''}`;
    }

    get selectedLabel() {
        return `Selected (${this.selectedQuestionIds.length})`;
    }
}