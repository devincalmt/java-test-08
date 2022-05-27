<link rel="stylesheet" href="css/header.css">

<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="<%= request.getContextPath()+"/home" %>">Home</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarText">
    <ul class="navbar-nav mr-auto"></ul>
    <span class="navbar-text">
      <form method="post" action="logout">
        <input type="submit" value="Logout" class="logout-btn">
      </form>
    </span>
  </div>
</nav>