package org.wso2.sample.workflow;

import java.util.List;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.wso2.carbon.apimgt.api.APIManagementException;
import org.wso2.carbon.apimgt.impl.APIConstants;
import org.wso2.carbon.apimgt.impl.dao.ApiMgtDAO;
import org.wso2.carbon.apimgt.impl.dto.SubscriptionWorkflowDTO;
import org.wso2.carbon.apimgt.impl.dto.WorkflowDTO;
import org.wso2.carbon.apimgt.impl.workflow.WorkflowConstants;
import org.wso2.carbon.apimgt.impl.workflow.WorkflowException;
import org.wso2.carbon.apimgt.impl.workflow.WorkflowExecutor;
import org.wso2.carbon.apimgt.impl.workflow.WorkflowStatus;

public class SubsCreationEmailSender extends WorkflowExecutor {
	
	private String adminEmail;
	
	private String emailAddress;
	
	private String emailPassword;

	@Override
	public List<WorkflowDTO> getWorkflowDetails(String arg0)
			throws WorkflowException {
		return null;
	}

	@Override
	public String getWorkflowType() {
		return WorkflowConstants.WF_TYPE_AM_SUBSCRIPTION_CREATION;
	}
	
	@Override
	public void execute(WorkflowDTO workflowDTO) throws WorkflowException{
		SubscriptionWorkflowDTO subsCreationWFDTO = (SubscriptionWorkflowDTO)workflowDTO;
		
		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");
		
		Session session = Session.getInstance(props,
				new javax.mail.Authenticator() {
					protected PasswordAuthentication getPasswordAuthentication() {
						return new PasswordAuthentication(emailAddress,
								emailPassword);
					}
				});
		
		try {
			 
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(emailAddress));
			message.setRecipients(Message.RecipientType.TO,
				InternetAddress.parse(adminEmail));
			message.setSubject("Subscription Creation");
			message.setText("Subscription created for API " + subsCreationWFDTO.getApiName() + 
							" using Application " + subsCreationWFDTO.getApplicationName() + 
							" by user " + subsCreationWFDTO.getSubscriber());
 
			Transport.send(message);
 
			System.out.println("Sent email to notify subscription creation");
			
			//Call the execute method of the parent class. This will create a reference for the
			//workflow execution in the database.
			super.execute(workflowDTO);

			//Set the workflow Status to APPROVED and Immediately complete the workflow since we 
			//are not waiting for an external party to complete this.
			workflowDTO.setStatus(WorkflowStatus.APPROVED);
			complete(workflowDTO);
 
		} catch (MessagingException e) {
			e.printStackTrace();
			throw new WorkflowException(e.getMessage());
		} catch (Exception e){
			e.printStackTrace();
			throw new WorkflowException(e.getMessage());
		}
	} 
	
	@Override
	public void complete(WorkflowDTO workflowDTO) throws WorkflowException{
		workflowDTO.setUpdatedTime(System.currentTimeMillis());
        super.complete(workflowDTO);

		ApiMgtDAO apiMgtDAO = new ApiMgtDAO();
		try {
			apiMgtDAO.updateSubscriptionStatus(
					Integer.parseInt(workflowDTO.getWorkflowReference()),
					APIConstants.SubscriptionStatus.UNBLOCKED);
		} catch (APIManagementException e) {
			throw new WorkflowException(
					"Could not complete subscription creation workflow", e);
		}
	}

	public String getAdminEmail() {
		return adminEmail;
	}

	public void setAdminEmail(String adminEmail) {
		this.adminEmail = adminEmail;
	}

	public String getEmailAddress() {
		return emailAddress;
	}

	public void setEmailAddress(String emailAddress) {
		this.emailAddress = emailAddress;
	}

	public String getEmailPassword() {
		return emailPassword;
	}

	public void setEmailPassword(String emailPassword) {
		this.emailPassword = emailPassword;
	}

}
