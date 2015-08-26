---
title: FAQS on Rancher
layout: rancher-default
---

## Container FAQs
---

### Why can I only edit the name of a container? 

Docker containers are immutable (not changeable) after creation. The only things you can edit are things that we store that aren't really part of the Docker container. This includes restarting, it's still the same container if you stop and start it. You will need to remove and recreate a container to change anything else. 

You can **Clone**, which will pre-fill the **Add Container** screen with all the setttings from an existing container. If you forget one thing, you can clone the container, change it, and then delete the old container. 

<a id="container-access"></a>

### Help! I cannot execute the shell or view logs of the container from the UI. How does Rancher access the shell/logs of a container? 

Since the agent is potentially open to the public internet, requests to the agent for a shell (or logs, etc) of a container aren't automatically trusted. The request from Rancher Server includes a JWT (JSON Web Token) and that JWT is signed by the server and can be verified by the agent to have actually come from the server. Part of that includes an expiration time, which is 5 minutes from when it is issued. This prevents a token from being used for long periods of time if it were to be intercepted, which is particularly important if not using SSL.

If you run `docker logs -f rancher-agent` and the logs show messages about an expired token, then please check that the date/time of the Rancher Server host and Rancher Agent host are in sync.

### What are my options with a container?

If you hover over the container, a drop down will appear on the right hand side.

* **Restart:** The container will be restarted.
* **Stop:** The container will be stopped.
* **Start:** This option appears if the container is already stopped. This will start the container again.
* **Delete:** The container will be deleted from the host.
* **View in API:** This will bring up the API for the specific container. If Access Control has been enabled, you will be prompted for a username/password.
* **Execute Shell:** You will be connected to the shell and be able to run commands in the container. Note: If you changed the IP of the host to a private IP, you will no longer be able to access this command. 
* **View Logs:** This will show the docker logs -f on the container.
* **Edit:** In the Edit screen, you have the ability to update some of the settings regarding the container. 

### Why does my container still show up after I have deleted it?

In the background, Rancher is taking care of the necessary steps to remove the container. Upon completion, Rancher UI will automatically refresh and remove the container. 

If you had accidentally deleted your container, you still have an option to save the container from deletion. Using the container’s drop down, you can **Restore** the container and it will stop it from being deleted. Restoring the container will keep it from being deleted, but you will need to **Start** the container to get it running again.

If you want to make the container disappear from your Rancher UI immediately, you can **Purge** the container after deleting it. 

### Why do my deleted containers still show up on the Containers page?

Even if the container is no longer showing on the hosts page, the Container may still show up on the Containers page. Since Rancher needs to spend some time deleting the Container, it will show up on the Container page as _Removed_ until Rancher has finished cleaning it up. If you’d like to have it removed immediately, you can use the drop down menu to **Purge** the container.
