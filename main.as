package
{
	import flash.display.Sprite;
	import flash.external.ExternalInterface;
	import flash.utils.Timer;
	
	import playerio.Client;
	import playerio.DatabaseObject;
	import playerio.PlayerIO;
	import playerio.PlayerIOError;

	public class Main extends Sprite
	{
		
		private function joinArrays(array:Array):String
		{
			var result:String = "";
			for each(var a:Array in array)
			{
				result += a.join() + "|";
			}
			return result;
		}
		public function Main()
		{
			trace("Played swf file.");
			//ExternalInterface.call("displayAlert", "Hello there!" + stage.loaderInfo.parameters[0]);
			// more stuff
			var i:Number;
			var world_names:Array;
			world_names = [];
			i = 0;
			
			PlayerIO.quickConnect.simpleConnect(stage, "everybody-edits-su9rn58o40itdbnw69plyw", "guest", "guest", function(client:Client):void{
				ExternalInterface.call("displayAlert","connected!");

				while (i < 4){
					//ExternalInterface.call("displayAlert",convertToWorld(stage.loaderInfo.parameters[i]));
				client.bigDB.load("Worlds",convertToWorld(stage.loaderInfo.parameters[i]),function(myDBObject:DatabaseObject):void{
					world_names.push(myDBObject["name"].toString());
					ExternalInterface.call("displayAlert",myDBObject["name"] + "->" + myDBObject["owner"]);
					
					ExternalInterface.call("updateLinks",world_names);
					
				})
				
				
				
				//ExternalInterface.call("displayAlert",stage.loaderInfo.parameters[i]+"OBJ");
				i++;
			}
				
			// playerio error
			},function(e:PlayerIOError):void{
				trace("Got", e)
			});
			

			
			
			ExternalInterface.call("updateLinks",world_names);
			
		}
		

		
		private function convertToWorld(param0:Object):String
		{
			var url_pieces:Array = param0.toString().split("/");
			return url_pieces[4];
		}		
		
	}
}
