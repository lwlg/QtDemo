#include <iostream>
#include <zmq.h>
#include <assert.h>
#include <stdio.h>
#include <windows.h>
#include "zhelpers.h"
using namespace std;

int main()
{
    cout << "Hello World!" << endl;
    int major, minor, patch;
    zmq_version (&major, &minor, &patch);
    printf ("Current 0MQ version is %d.%d.%d\n", major, minor, patch);

    ////
//    void *context = zmq_init(1);//指定处理IO事件的Thread pool1
//    void *socket = zmq_socket (context, ZMQ_REP);
//    int rc = zmq_bind(socket,"tcp://*:5555");
//    assert(rc == 0);
//    int recvn =1;
//    while(1)
//    {
//       zmq_msg_t recv_msg;
//       rc = zmq_msg_init (&recv_msg);
//       rc = zmq_msg_recv(&recv_msg,socket,0);
//       assert (rc != -1);
//       Sleep(1);
//       printf("recv client info:%d\n",recvn++);
//       printf("client recv:%s\n",(char*)zmq_msg_data(&recv_msg));
//       zmq_msg_close(&recv_msg);

//       // 已到达最后一帧
//       int64_t more;
//       size_t more_size = sizeof more;
//       rc = zmq_getsockopt (socket, ZMQ_RCVMORE, &more, &more_size);
//       assert (rc == 0);
//       if (!more)
//           break;

//       zmq_msg_t send_msg;
//       zmq_msg_init_size(&send_msg,6);
//       memcpy(zmq_msg_data(&send_msg),"world",6);
//       zmq_msg_send(&send_msg,socket,0);
//       zmq_msg_close(&send_msg);
//    }
//    zmq_close(socket);
//    zmq_term(context);

//    void *context = zmq_ctx_new();
//    void *publisher=zmq_socket(context,ZMQ_PUB);
//    int  rc = zmq_bind(publisher,"tcp://*:5556");
//    assert(rc == 0);

//    srandom((unsigned)time(NULL));
//    while (1) {
//        int zipcode,temperature,relhumidity;
////        zipcode = randof(100000);
//        zipcode = 100001;
//        temperature = randof(215)-80;
////        relhumidity = randof(50)+10;
//        relhumidity = 100002;
//        char update[20];
//        sprintf(update,"%05d %d %d",zipcode,temperature,relhumidity);
//        s_send(publisher,update);
//        printf("%s\n",update);
//        Sleep(1000);
//    }

    void *context = zmq_ctx_new ();
    void *sender = zmq_socket (context, ZMQ_PUSH);
    zmq_bind (sender, "tcp://*:5557");

    void *sink = zmq_socket (context, ZMQ_PUSH);
    zmq_connect (sink, "tcp://localhost:5558");

    printf ("Press Enter when the workers are ready: ");
    getchar ();
    printf ("Sending tasks to workers…\n");
    //  The first message is "0" and signals start of batch
    s_send (sink, "0");
    //  Initialize random number generator
    srandom ((unsigned) time (NULL));
    //  Send 100 tasks
    int task_nbr;
    int total_msec = 0;     //  Total expected cost in msecs
    for (task_nbr = 0; task_nbr < 100; task_nbr++) {
        int workload;
        //  Random workload from 1 to 100msecs
        workload = randof (100) + 1;
        total_msec += workload;
        char string [10];
        sprintf (string, "%d", workload);
        s_send (sender, string);
    }
    printf ("Total expected cost: %d msec\n", total_msec);

    zmq_close (sink);
    zmq_close (sender);
    zmq_ctx_destroy (context);


    return 0;
}

static Singleton* getInstatce()
{
    if(NULL == instance)
    {
        lock();
        if(NULL == instance)
        {
            instance = new Singleton();
        }
        unlock();
    }
    return instance;
}




