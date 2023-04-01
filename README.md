<h1>2048-bash</h1>
<hr>
<p>This is a Bash Shell implementation of the popular 2048 game. The game is played on a 4x4 grid where the user combines adjacent tiles with the same value to create a tile with a higher value until they reach the 2048 tile.</p>


<h2>Prerequisites</h2>
<hr>
<p>Before running the game, make sure you have the following prerequisites:</p>
<li>Bash shell environment</li>


<h2>How To Run?</h2>
<hr>
<ol>
<li>Clone the repository to your local machine using 'git clone'.</li>
<li>In terminal Navigate to the directory where the repository is cloned.</li>
<li>Run the 2048.sh script using 'bash 2048.sh'.</li>
<li>Follow the instructions on the screen to play the game.</li>
</ol>


<h2>Rules of Game</h2>
<hr>
<ul>
<li>The game board is a 4x4 grid of cells, where each cell can have a value of a power of 2, from 2 to 2048.</li>
<li>The objective of the game is to combine the cells with the same value to obtain a cell with the value of 2048.</li>
<li>You can move the cells in four directions: up, down, left, and right, by using the arrow keys or the w, a, s, d keys.</li>
<li>When you move the cells, the cells with the same value will combine, and a new cell with the value of their sum will appear.</li>
<li>The game ends when there are no more possible moves, i.e., when the board is full, and there are no adjacent cells with the same value.</li>
</ul>


<h2>Code Explanation</h2>
<hr>
<p>The code is written in Shell Bash and consists of several functions that perform different tasks:</p>
<ol>
<li>Initial_Display(): Clears the screen and asks the player to enter their name.</li>
<li>Display_Board(): Displays the game board, including the player's name, score, and number of moves.</li>
<li>First_Turn(): Generates two random numbers (either 2 or 4) on the board for the first turn.</li>
<li>Generate_New_Number(): Generates a new random number (either 2 or 4) on the board.</li>
<li>Up_Move(): Moves the tiles up on the board if possible, combining tiles if they have the same value.</li>
<li>Down_Move(): Moves the tiles down on the board if possible, combining tiles if they have the same value.</li>
</ol>


<h2>Screenshots</h2>
<hr>

![initial_display](https://user-images.githubusercontent.com/96474143/229311502-5e5862a2-1085-465e-a636-f51b83445636.png)

![display_board](https://user-images.githubusercontent.com/96474143/229311510-fb445b71-09bd-4407-8d53-1e0d6ad67fd5.png)

![play_game](https://user-images.githubusercontent.com/96474143/229311516-403bc275-c642-4321-9445-ee9d73dca9c2.png)
