<h1 align="center">SoundState 🎵</h1>
<p>
</p>

A smart playlist curator that allows you to filter your Spotify library according to your mood, and uses AI to generate a unique image for each playlist, for you to share and discover music that you love.

We made this as a team of 4 for our final 2 week project at Le Wagon's web dev bootcamp.

<a><img src="app/assets/images/soundstate-demo-short.gif"></a>
<a><img src="https://res.cloudinary.com/drftmp0s5/image/upload/v1681239925/filters_dni68w.png" style="width: 300px"></a>
<a><img src="https://res.cloudinary.com/drftmp0s5/image/upload/v1681239925/playlist-show_j43wr4.png" style="width: 300px"></a>
<a><img src="https://res.cloudinary.com/drftmp0s5/image/upload/v1681239926/gallery_pyc0sz.png" style="width: 300px"></a>

### ✨ [Demo](https://www.soundstate.live/)

<h2>Technologies and Learning Points</h2>
<p align="left">

<a href="https://www.w3.org/html/" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/html5/html5-original-wordmark.svg" alt="html5" width="40" height="40"/> </a><a href="https://www.w3schools.com/css/" target="_blank" rel="noreferrer">
<img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/css3/css3-original-wordmark.svg" alt="css3" width="40" height="40"/> </a>
<a href="https://getbootstrap.com" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/bootstrap/bootstrap-plain-wordmark.svg" alt="bootstrap" width="40" height="40"/> </a><a href="https://sass-lang.com" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/sass/sass-original.svg" alt="sass" width="40" height="40"/> </a> </p>

- Understanding of responsive web design: in this case, mobile-first design as we envision it being used mainly as a mobile app
- Implementation of Progressive Web App for the same reason
- Customizing bootstrap colour variables, according to our Figma prototype
- Working with components and using Sass to write CSS in a more organised way

<a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/javascript/javascript-original.svg" alt="javascript" width="40" height="40"/> </a>

- This project was great for developing our skills in Stimulus JS and Ajax.

<a href="https://www.ruby-lang.org/en/" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/ruby/ruby-original.svg" alt="ruby" width="40" height="40"/> </a>
<a href="https://rubyonrails.org" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/rails/rails-original-wordmark.svg" alt="rails" width="40" height="40"/> </a>

- Building a better understanding of MVC architecture
- Adopting RoR conventions and best practices
- Applying RESTful principles: with the use of 2 APIs we made a conscious effort to keep the routes RESTful

<a href="https://www.postgresql.org" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/postgresql/postgresql-original-wordmark.svg" alt="postgresql" width="40" height="40"/> </a>

- How to define database schema, perform CRUD operations, database migrations. We are aware of the importance of a sound database structure and spent time trying to establish this from the beginning. One particular dilemma we faced was whether or not to store the user's songs in our own database. We ended up electing to do this as it was much more efficient to query our database when filtering songs than to make an API request each time.

- Importance of validations to ensure data integrity and consistency

<a href="https://www.figma.com/" target="_blank" rel="noreferrer"> <img src="https://www.vectorlogo.zone/logos/figma/figma-icon.svg" alt="figma" width="40" height="40"/> </a> <a href="https://git-scm.com/" target="_blank" rel="noreferrer"> <img src="https://www.vectorlogo.zone/logos/git-scm/git-scm-icon.svg" alt="git" width="40" height="40"/> </a> <a href="https://heroku.com" target="_blank" rel="noreferrer"> <img src="https://www.vectorlogo.zone/logos/heroku/heroku-icon.svg" alt="heroku" width="40" height="40"/> </a>

- Figma: designing a user-centric app, designing with components, producing a low fidelity prototype
- Collaboration via Github, PRs, resolving merge conflicts
- Deployment via Heroku, management of database on Heroku, environment variables

Other key learning points:

- Knowledge of integrating third-party services eg. Spotify API, openAI API, honing our skills of reading documentation and troubleshooting
- User authentication via Spotify, understanding OAuth, scopes for user privacy and data protection
- Agile methodologies: we had daily stand-up meetings and used Trello for project management. We learnt the importance of being flexible when we came across limitations of the APIs. One example of this was having to create a playlist in the user's Spotify account to allow autoplaying through embedded iframes. Our initial desire to use the webplayer SDK had to be adapted as this did not allow for continuous playback, which we felt was integral to the user experience.

</p>

Thanks for reading 🤓
