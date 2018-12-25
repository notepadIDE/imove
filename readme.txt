robowizard v1-beta

This is a robocopy assistant utlity to help soften the robocopy cli tool, without neutering it.

USAGE:

-> To back-up profile:

	1) Log in as the user whose profile you wish to migrate.
	2) Place robowizard.bat anywhere on the source system.
	3) Run robowizard.bat as administrator, choose quick transfer, follow prompts
	*4) Copy robowizard.bat into the robowizarddata directory, to readily integrate folders onto new system
	
-> To restore a transferred profile:

	1) Log in as the user whose profile you wish to import.
	2) Place robowizard.bat anywhere on the source system.
	3) Run robowizard.bat as administrator, choose quick transfer, follow prompts

What it actually does (quick transfer):

	This script just copies the 5 most commonly used user data directories on Windows systems (Desktop, 
	Documents, Music, Pictures, Videos) to a target of the user's choosing, at which point the user can
	place robowizard.bat the destination machine and run it to copy over the
	contents of the old user profile.

	This script utilizes the internal Windows utility Robocopy to execute it's copy jobs. They are non-
	destructive, fault tolerant, file attribute inclusive copies. In english, it's safe, dependable, 
	and thorough. Robocopy is also faster than just copying via file explorer.
	
	The script is pretty basic because it's bash (for backwards compatibility). So, it pulls the correct
	directory locations (for the transfers) by pulling the USERNAME system variable. As a result, you 
	have to be logged in as that user, otherwise it will send it to the wrong user's profile.
	
What it actually does, actually (quick transfer):

	[source mode] Robocopies Desktop/Documents/Music/Photos/Videos to a user-specified destination. Non-mirror.
	  On error: 3 retries over 30 seconds, then pass.

	[destination mode] Robocopies Desktop/Documents/Music/Photos/Videos from a user-specified destination.
	  (same destination specified on the source machine, typically) Non-mirror. On error: 3 retries over 30
	  seconds, then pass.

Advanced operation mode:

	This script also includes an advanced mode. Advanced mode literally just takes all your inputs and feeds 
	them into robocopy. I won't go into a dissertation of robocopy, but basically it allows you granular 
	control of copy jobs. So the advanced mode allows you to exclude files/directories in your copy jobs.
	Directories must be absolute, and separated by a space. Files can be relative, and can also include
	wildcard expressions.
