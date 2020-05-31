<aura:application extends="force:slds">
    <lightning:tabset selectedtabid="two" variant="scoped">
    	<lightning:tab label="ASSOCIATES" id="one">
            <c:AssociateWrapper/>
        </lightning:tab>
        <lightning:tab label="MEETINGS" id="two">
            <c:MeetingAssignment/>
        </lightning:tab>
    	<lightning:tab label="QUESTIONS" id="three">
            <c:QuestionCreation/>
        </lightning:tab>
    </lightning:tabset>
</aura:application>