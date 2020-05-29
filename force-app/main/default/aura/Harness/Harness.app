<aura:application extends="force:slds">
    <lightning:tabset selectedtabid="two" variant="scoped">
    	<lightning:tab label="ASSOCIATES" id="one">
            Content 1
        </lightning:tab>
        <lightning:tab label="MEETINGS" id="two">
            <c:CreateMeeting/>
            <c:MeetingTiles/>
        </lightning:tab>
    	<lightning:tab label="QUESTIONS" id="three">
            <c:QuestionCreation/>
        </lightning:tab>
    </lightning:tabset>
</aura:application>