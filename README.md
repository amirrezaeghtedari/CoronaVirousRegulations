# Corona Virous Regulations

## Overview
This iOS application checks the number of COVID 19 incidents in the region of the user and classifies the infection threat level. Threat levels are divided into four colors, green, yellow, red, and dark red. Regarding the current threat level, specific and general regulations will be represented to the user. The app checks the number of incidents every 10 minutes, both in foreground and background mode by RESTFul API calls. When the app is in background mode, if the threat level changes from the last time it was in foreground mode, it informs the user about the threat level change by sending a local user notification.

### Copyright
This project was initiated as a job application assessment by the [Hahn Softwareentwicklung](https://www.hahn-softwareentwicklung.de) company originally.

All images and vectore graphics are under the person use license of the [freevectors.com](https://www.freevector.com).

## Compile and run prerequisites
There are no special requirements for compiling this app. It uses Apple Xcode and does not need any third-party libraries.

## Testing
### Simulating location to Germany
The endpoint API uses the current location of the user to check the number of COVID 19 incidents in that region. This API is only available in Germany, and in other areas, it fails to retrieve the number of incidents. For testing the application on iOS devices, in countries other than Germany, replace all the instantiations of the **LocationProvider** class with the **LocationProviderMock**. LocationProvider is the class that retrieves the current location using the phone location services. The LocationProviderMock simulates it if there is somewhere in Germany. As Xcode simulator allows you simulate the current location, there is no need to use the LocationProviderMock on Xcode simulator. 

### Simulating different number of incidents
As this is not easy to find places with all kinds of threat levels, we can use the **IncidentsProviderMock** instead of the **IncidentsProvider**. IncidentsProvider is the class that retrieves the number of incidents by calling remote server API. The IncidentsProviderMock simulates the number of retrieved incidents randomly such that all levels of threats can be simulated easily.

### Simulating backgrond fetch
This application supports background fetch. To implement that feature, it uses the BGTaskScheduler that is a new API that was introduced in 2019 for iOS 13 and later. As we, as developers, do not want to wait for elapsing the duration, we can use simulating the background fetch using the following procedure:

1. Set a breakpoint at the end of the **sceneDidEnterBackground** in the **SceneDelegate.swit**.
2. Run the app on a device and send it to the background.
3. In the debuggre, execute the line below:
		`e -l objc -- (void)[[BGTaskScheduler sharedScheduler] _simulateLaunchForTaskWithIdentifier:@"com.amirrezaeghtedari.coronaVirousRegulations.incidents.fetch"]`
1. Resume the app. The system calls the launch handler for the background task.
