//
// Copyright (C) 2000 Institut fuer Telematik, Universitaet Karlsruhe
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
//






package inet.examples.inet.multicast;

import inet.nodes.inet.Router;
import inet.nodes.inet.StandardHost;
import ned.DatarateChannel;


network MulticastNetwork
{
    types:
        channel ethernet extends DatarateChannel
        {
            delay = normal(0.00015s, 0.00005s);
            datarate = 10Mbps;
        }
        channel dialup extends DatarateChannel
        {
            delay = normal(0.004s, 0.0018s);
            datarate = 64kbps;
        }
        channel fiberrouter extends DatarateChannel
        {
            delay = normal(0.000001s, 0.0000001s);
            datarate = 512Mbps;
        }
    submodules:
        host1: StandardHost {
            parameters:
                IPForward = false;
                routingFile = "mchost1.mrt";
                @display("p=125,52;i=device/pc2");
            gates:
                pppg[1];
        }
        host2: StandardHost {
            parameters:
                IPForward = true;
                routingFile = "mchost2.mrt";
                @display("p=60,244;i=device/pc2");
            gates:
                pppg[2];
        }
        host3: StandardHost {
            parameters:
                IPForward = true;
                routingFile = "mchost3.mrt";
                @display("p=196,244;i=device/pc2");
            gates:
                pppg[2];
        }
        host4: StandardHost {
            parameters:
                IPForward = false;
                routingFile = "mchost4.mrt";
                @display("p=406,305;i=device/pc2");
            gates:
                pppg[1];
        }
        host5: StandardHost {
            parameters:
                IPForward = false;
                routingFile = "mchost5.mrt";
                @display("p=492,59;i=device/pc2");
            gates:
                pppg[1];
        }
        host6: StandardHost {
            parameters:
                IPForward = false;
                routingFile = "mchost6.mrt";
                @display("p=492,204;i=device/pc2");
            gates:
                pppg[1];
        }
        router1: Router {
            parameters:
                routingFile = "mcrouter1.mrt";
                @display("p=124,135");
            gates:
                pppg[4];
        }
        router2: Router {
            parameters:
                routingFile = "mcrouter2.mrt";
                @display("p=292,135");
            gates:
                pppg[3];
        }
        router3: Router {
            parameters:
                routingFile = "mcrouter3.mrt";
                @display("p=292,238");
            gates:
                pppg[2];
        }
        router4: Router {
            parameters:
                routingFile = "mcrouter4.mrt";
                @display("p=408,135");
            gates:
                pppg[3];
        }
    connections:
        // * Domain 1 * (172.0.0.x)
        host1.pppg[0] <--> ethernet <--> router1.pppg[0];
        host2.pppg[0] <--> ethernet <--> router1.pppg[1];
        host2.pppg[1] <--> dialup <--> host3.pppg[1];
        host3.pppg[0] <--> ethernet <--> router1.pppg[2];

        // * Domain 2 * (172.0.1.x)
        host4.pppg[0] <--> ethernet <--> router3.pppg[0];

        // * Domain 3 * (172.0.2.x)
        host5.pppg[0] <--> dialup <--> router4.pppg[0];
        host6.pppg[0] <--> dialup <--> router4.pppg[1];

        // * Router Connections * (172.1.0.x)
        router2.pppg[0] <--> fiberrouter <--> router1.pppg[3];
        router2.pppg[1] <--> fiberrouter <--> router3.pppg[1];
        router2.pppg[2] <--> fiberrouter <--> router4.pppg[2];
}

