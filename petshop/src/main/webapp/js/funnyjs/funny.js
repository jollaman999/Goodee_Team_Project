var ToDoList = new Array();
ToDoList[0] = "command:"
var newToDo = 0;
var del = 0;
var path = "C:\\Users\\Soll LEE>";
function cmd(e) {
    command = document.getElementById("cmd").value;
    //e.preventDefault();
    if (e.keyCode == 13) {
        document.getElementById("result").innerHTML += path + command + '<br>';
        if (command === "") {
        } else if (command === "help") {
            document.getElementById("result").innerHTML += "help<pre>      </pre><br>";
            document.getElementById("result").innerHTML += "list<pre>       </pre><br>";
            document.getElementById("result").innerHTML += "profit_d<pre>    </pre><br>";
            document.getElementById("result").innerHTML += "profit_m<pre>    </pre><br>";
            document.getElementById("result").innerHTML += "profit_y<pre>    </pre><br>";
            document.getElementById("result").innerHTML += "order<pre>      </pre><br>";
            document.getElementById("result").innerHTML += "management<pre>      </pre><br>";
            document.getElementById("result").innerHTML += "add<pre>      </pre><br>";
            document.getElementById("result").innerHTML += "game<pre>      </pre><br>";
            document.getElementById("result").innerHTML += "memo<pre>      </pre><br>";
            document.getElementById("result").innerHTML += "exit<pre>      </pre><br>";

    
        } else if (command === "exit" && newToDo !== 1 && del !==1) {
            ToDoList.splice(1, ToDoList.length - 1);
            document.getElementById("result").innerHTML += "success<br>";       
            location.href = 'http://localhost:8080/petshop/index.jsp';
            
        } else if (command === "list" && newToDo !== 1 && del !==1) {
            ToDoList.splice(1, ToDoList.length - 1);
            document.getElementById("result").innerHTML += "success<br>";       
            location.href = 'http://localhost:8080/petshop/admin/list.shop';   
            
        } else if (command === "profit_d" && newToDo !== 1 && del !==1) {
            ToDoList.splice(1, ToDoList.length - 1);
            document.getElementById("result").innerHTML += "success<br>";       
            location.href = 'http://localhost:8080/petshop/inventory/money_day.shop';
            
        } else if (command === "profit_m" && newToDo !== 1 && del !==1) {
            ToDoList.splice(1, ToDoList.length - 1);
            document.getElementById("result").innerHTML += "success<br>";       
            location.href = 'http://localhost:8080/petshop/inventory/money_month.shop';
            
        } else if (command === "profit_y" && newToDo !== 1 && del !==1) {
            ToDoList.splice(1, ToDoList.length - 1);
            document.getElementById("result").innerHTML += "success<br>";       
            location.href = 'http://localhost:8080/petshop/inventory/money_year.shop';
            
            
        } else if (command === "order" && newToDo !== 1 && del !==1) {
            ToDoList.splice(1, ToDoList.length - 1);
            document.getElementById("result").innerHTML += "success<br>";       
            location.href = 'http://localhost:8080/petshop/inventory/selling.shop';  
            
        } else if (command === "management" && newToDo !== 1 && del !==1) {
            ToDoList.splice(1, ToDoList.length - 1);
            document.getElementById("result").innerHTML += "success<br>";       
            location.href = 'http://localhost:8080/petshop/inventory/list.shop'; 
       
        } else if (command === "add" && newToDo !== 1 && del !==1) {
            ToDoList.splice(1, ToDoList.length - 1);
            document.getElementById("result").innerHTML += "success<br>";       
            location.href = 'http://localhost:8080/petshop/item/create.shop?pageNum='; 
        
       } else if (command === "game" && newToDo !== 1 && del !==1) {
            ToDoList.splice(1, ToDoList.length - 1);
            document.getElementById("result").innerHTML += "success<br>";       
            location.href = 'http://localhost:8080/petshop/inventory/funnygame.shop'; 
            
       } else if (command === "memo" && newToDo !== 1 && del !==1) {
           ToDoList.splice(1, ToDoList.length - 1);
           document.getElementById("result").innerHTML += "success<br>";       
           location.href = 'http://localhost:8080/petshop/inventory/memo.shop'; 
  	
        } else {
            document.getElementById("result").innerHTML += '"' + command + '"' + '<br>';
        }
    document.getElementById("cmd").value = "";
    document.getElementById("label").innerHTML = path;
    window.scrollTo(0, document.documentElement.scrollHeight);
    }
}