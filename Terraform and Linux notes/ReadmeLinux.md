Linux

Let say we have a py program using Hardware which has CPU n memory through an OS (which maintains cpu, memory management,/w management) . Now, assume py program is running or taking a lot of time to execute, it utilizes most of the hardware and holds it, and other scripts hv to wait until py is done execution. Now we have out of memory error or 100%utilized, we can deal with 1)viewing the process running or check 2)kill certain processors or stop 3)prioritize the processors(generally if cpu is taking time for an app it assumes it is priority for this we can deprioritize it)

Command:
Ps aux —> list all processors running
- Ps aux | nl -> list the no.of processors 
- Ps aux | wc -l  —> just gives u d number of processors there in total

Difference btw ps aux and ps -ef : is ps aux gives/shows  u cpu and memory details where as ps -ef doesn’t show 

Now, to check the process we’ll look into : ps aux command
Not is to kill—> ie kill process_id(which u check with ps the processors will still show)
Now remove that killed process we use kill -9 process_id

Kill -3 to get threat dumps
To temp stop process : kill -STOP process_id n to resume it kill -CONT process_id

——TO prioritize or depriotize d process:
Comm: renice -n 10 -p 4048

Here , -n 10 means let say higher number less cpu prioritize, if we have -n -5 -p  <process_id> -this is imp than -19 . 

—————————
Services r special kind of process when boot ins stored ie whenever boot is stated services starts. Can be change process to service ? Yes, most of them servers or installation scripts r starting as service.

Vmstat-reports sys performance.
Free -m —>free memory info
Nproc- available cpu on machine,htop 

 Cpu- proc,htop
Memory: free -h, htop
Disk: df -h, du —sh *

——————————
Linux have volume say 8gb, initially this would be sufficient but later when app  increases, it keeps collecting file for logs, audit,debug and store or usually zip them and store in d same instance. 
So, to increase/add the size or volume of instance , we can add storage to it but just by adding we have to mount it to linux,so the app can access, now this storage the we create is block storage so app can’t access it for the we need to format it by using ext 4 etc.
Using comm: lsblk provides u about list of how 8gb is used with partitions.and comm:sudo disk -l gives u the exact storage allocation. 
Now if u want to create storage on aws we hv EBS ie elastic block storage. In ebs instead of mounting the hole , ebs with 8gb will partition let say 4 parts 1 part is mounted to root and other part to /boot etc.
 To convert ebs - mkdir -p /mnt/demo-volume(here demo volume is a temp name  for the loc)
Ls -ltr/mnt
To convert- mkfs -t ext4 /dev/xvfd
