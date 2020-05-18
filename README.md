# Absences App

The purpose of this project is to provide the teachers of Les Roches a tool to indicate the absences of students in their classes

### Prerequisites

To install the project in your system it's necessary to install the following software:
- Maven Wrapper
- Eclipse IDE - download the last version from https://www.eclipse.org/
- Tomcat7 - download from https://tomcat.apache.org/download-70.cgi
- JRE 7 - download from http://www.oracle.com/technetwork/java/javase/downloads/java-archive-downloads-javase7-521261.html
- Java Cryptography Extension (JCE) - download from https://www.oracle.com/technetwork/java/javase/downloads/jce8-download-2133166.html
- Node.js 10 + npm - download from https://nodejs.org

### Frontend build

Frontend is built through a Gulp buildfile, that requires some npm packages to be installed locally. The first time you must install npm packages:

`npm install`

If a commit adds more npm packages dependencies, you will need to run again this command in order to make Gulp work.

After every change in frontend files, you would need to run this command:

`gulp build`

In case you don't have a global gulp installed, you can run your locally installed gulp with this command:

Windows
`node_modules\.bin\gulp build`

MacOS/Linux
`./node_modules/.bin/gulp build`

This will build 2 main HTML files:
- index.html: Page that will load unminified JS, CSS and not compiled Riot.js tags. This is the version recommended for local development.
- index-min.html: Page that will load minified JS, CSS and compiled+minified Riot.js tags. This is the version recommended for production environments.

If you only want to build minified and bundled version of frontend, you must run this command instead:

`gulp release`

This will only build a HTML file called index.html, that will be the minified version using this option.

If you are a frontend developer, you may want to run the following command for tracking changes and running a lightweight HTTP server:

`gulp run-browser`

This will point to [TO BE DEFINED] server.

### Frameworks used
- JSF
- Primefaces
- Hibernate

### Installing

0- Initialize Maven Wrapper local repository

### Setup Maven Wrapper
The Maven Wrapper is an easy way to ensure a user of your Maven build has everything necessary to run your ## Maven build. Why might this be necessary? Maven to date has been very stable for users, is available on most systems or is easy to procure: but with many of the recent changes in Maven it will be easier for users to have a fully encapsulated build setup provided by the project. With the Maven Wrapper this is very easy to do and it's a great idea borrowed from Gradle.

The easiest way to setup the Maven Wrapper for your project is to use the Takari Maven Plugin with its provided wrapper goal. To add or update all the necessary Maven Wrapper files to your project execute the following command:

`mvn -N io.takari:maven:wrapper`

Normally you instruct users to run the mvn command like the following:

`mvn clean install`

But now, with a Maven Wrapper setup, you can instruct users to run wrapper scripts:

`mvnw clean install`

$ ./mvnw.cmd clean install

A normal Maven build will be executed with the one important change that if the user doesn't have the necessary version of Maven specified in .mvn/wrapper/maven-wrapper.properties it will be downloaded for the user first.

1- Install JRE 7 on your system

2- Install the JRE in Eclipse 

- Open the Java > Installed JREs preference page.
- Select the Add... button. The Add JRE wizard opens.
- You will have to select the installed JRE path in your system

3- Install the Tomcat in Eclipse
follow the instruction detailed in https://crunchify.com/step-by-step-guide-to-setup-and-install-apache-tomcat-server-in-eclipse-development-environment-ide/ for the tomcat version that you need

4- Install the project in Eclipse 
You should follow these steps to import the project using Maven in Eclipse IDE.
- Open Eclipse.
- Click File > Import.
- Type Maven in the search box under Select an import source:
- Select Existing Maven Projects.
- Click Next.
- Click Browse and select the folder project 
- Click Next.
- Click Finish.

5- Add the project to Tomcat
It's necessary to create a relationship between the project and your server. This is done by adding your project to a server:
- In the Servers view, right-click on the server and select Add and Remove Projects.
- In the Available projects list, select the project that you want to test and click Add.
- The project appears in the Configured projects list. If a project name appears in italic font style, this means the project has not yet been uploaded to the server. Click Finish.
Note: When you select a project to add to the server, only the projects that are applicable to the type of server will appear.

6- Install Java Cryptography Extension (JCE).
Follow the instruction detailed in https://docs.oracle.com/cd/E84221_01/doc.8102/E84237/index.htm?toc.htm?212338.htm

7- Starting the project

### Build & Run Spring Boot application 

```
mvn package` or `./mvnw package
```

### Run absences management application from command line

```
java -Dspring.profiles.active=local -Djasypt.encryptor.password=MyWeakSecret -jar target/absences-management-0.6.0.jar
```

### Run encryptor tool from Eclipse Java Runner

This aplicaction can only be executed before the maven package process.

Into run configuration: 

- **Add VM argument** `-Djasypt.encryptor.password=MyWeakSecret`
- **Add Program arguments** : `--secret MyWeakSecret --property-file all (or a comma-separated list of environments)`

###### Important: The file (s) will be generated in the \ target \ classes \ folder. If you need to upload the configuration file with these keys, get those keys from the file located in \ target \ classes \ either by taking that key or copying and pasting the corresponding .yml file into the resources / project folder.



The server is automatically started when you right-click on a file of the project and then select Run As > Run on Server.

It also can manually start a server:
- Switch to the Servers view.
- In the Servers view, right-click the server you want to start.
- Select Start. The following events happen:
- If you have selected the Automatically publish when starting servers check box on the Server preferences page (Window > Preferences > Server > Launching ), the workbench checks to see if your project and files on the server are synchronized prior to starting the server. If they are not, the project and the files are automatically updated on the remote server when it is started.
- A Console view opens in the workbench. It will take a minute to start the server. If the server fails to start, check for the reason that it failed in the Console.
- In the Servers view, the status of the server changes to Started.


## Configuration

The project configuration is defined in:
- the file hibernate.cfg.xml located in \src\main\resources, where is defined the location of the database used by the application.
- the file configuracion.properties.cfg located in \src\main\resources\properties where is the configuration of the Active Directory, the LDAP and the WS that is called when the absences are submitted

## Deployment

Add additional notes about how to deploy this on a live system

## Versioning

We use [GitLab](https://about.gitlab.com/) for versioning. 


## Install MS Sql Server Docker Container in MacOS as Service

- Reference: 
https://adamwilbert.com/blog/2018/3/26/get-started-with-sql-server-on-macos-complete-with-a-native-gui

docker pull microsoft/mssql-server-linux:2017-latest

docker run -e 'ACCEPT_EULA=Y' -e 'MSSQL_SA_PASSWORD=ReallyStrongPassword12341234' -p 1433:1433 --name mssql -v mssqlvolume:/var/opt/mssql -d microsoft/mssql-server-linux:2017-latest

## Connecting to DO Jenkins X Kubernetes cluster

- Reference:
https://www.digitalocean.com/docs/kubernetes/how-to/connect-to-cluster/

`doctl auth init`
You will be asked for an API key, ask your devops for it

`doctl kubernetes cluster kubeconfig save netscale-k8s-jx`

## Accessing to staging MSSQL instance

Once you are connected to the cluster, you must run:

`kubectl get pods -n databases`

Copy the name of the mssql pod, then run:

`kubectl -n databases port-forward <mssql_pod_name> 1433`

Then, left that shell on background and use: `localhost:1433` to connect to the staging remote instance. 

If you experience problems with it, remember to stop any local service or container executing MSSQL.