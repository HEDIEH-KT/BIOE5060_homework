fid = fopen('README.txt', 'w'); % Open the file for writing

fprintf(fid, '### Pong MATLAB Game Project\n\n');
fprintf(fid, '**Project Overview:**\n');
fprintf(fid, 'This project is a MATLAB GUI implementation of the Pong game.\n');
fprintf(fid, '\n**Key Features:**\n');
fprintf(fid, '- Ball movement controlled by speed and direction.\n');
fprintf(fid, '- Red and blue bats controlled using keyboard inputs.\n');
fprintf(fid, '- Speed slider to adjust the game speed.\n');
fprintf(fid, '- Score updates when a bat fails to intercept the ball.\n');
fprintf(fid, '\n**Controls:**\n');
fprintf(fid, '- **Red Bat**: Press **"w"** to move up, **"s"** to move down.\n');
fprintf(fid, '- **Blue Bat**: Press **"o"** to move up, **"k"** to move down.\n');
fprintf(fid, '\n**How to Run:**\n');
fprintf(fid, '1. Open the provided project in MATLAB.\n');
fprintf(fid, '2. Click on the **Start button** to begin the game.\n');
fprintf(fid, '3. Use the speed slider to adjust the speed of the ball.\n');
fprintf(fid, '4. Observe the scoring updates as gameplay progresses.\n');
fprintf(fid, '\n**Demo Video:**\n');
fprintf(fid, 'A demo video of the gameplay has been included in the project folder as demo_video.mp4.\n');

fclose(fid); % Save and close the file
disp('README.txt has been successfully created.');
