<aura:application extends="force:slds">
    <!-- All the Attributes are used to set Static value for the [Sub_Tech] object each of the attribute are the name of the subtech,thats means it is record in subtech object-->    
   <!-- <aura:attribute name="Apexvalue" type="String" default='a064W00003sQ590QAC'/>
    <aura:attribute name="AuraValue" type="String" default='a064W00003sQ595QAC'/>
    <aura:attribute name="WorkflowValue" type="String" default='a064W00003sQ58vQAC'/>
    <aura:attribute name="ProcessBuilderValue" type="String" default='a064W00003sQ58rQAC'/>-->
    
    <!--all the lines below this comment is used for set all above static values to attribute in HARNESSEVENT.evt resource so once the button is clicked it will call corrosponding functions from controller -->
   <!-- <aura:registerEvent name="loadMyEvent" type="c:Harnessevent"/>
     <lightning:button variant="brand" label="Apex" title="Brand action" onclick="{!c.changeStatusApex}" />
 	<lightning:button variant="brand" label="Aura" title="Brand action" onclick="{!c.changeStatusAura}" />
    <lightning:button variant="brand" label="Workflow" title="Brand action" onclick="{!c.changeStatusWorkflow}" />
    <lightning:button variant="brand" label="ProcessBuilder" title="Brand action" onclick="{!c.changeStatusProcessBuilder}" />
    <c:ChallangeComponent/>-->
</aura:application>