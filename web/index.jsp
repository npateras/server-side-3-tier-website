<jsp:include page="default.jsp"/>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<LINK REL=STYLESHEET
      HREF="CSS/Slideshow.css"
      TYPE="text/css">
<html>
  <head>
    <title>Movie Theaters</title>
    <style type="text/css">
        .slideshow-header {
            font: 25px Georgia, serif;
            -moz-border-radius: 6px;
            text-align: center;
            width: 1000px;
            background: black;
            padding: 10px;
            margin: auto;
            margin-top: 35px;
            text-shadow: 1px 1px 2px black, 0 0 1em #ffcf0c, 0 0 0.2em #ffcc00;
        }
    </style>
  </head>
  <body>
      <br><br><br>

      <div class="slideshow-header">Coming Soon</div>
      <div class="slideshow-container">

          <div class="mySlides fade">
              <img src="Resources/soon1.jpg" alt="coming-soon-1" style="width: 100%">
          </div>

          <div class="mySlides fade">
              <img src="Resources/soon2.jpg" alt="coming-soon-2" style="width:100%">
          </div>

          <div class="mySlides fade">
              <img src="Resources/soon3.jpg" alt="coming-soon-3" style="width:100%">
          </div>

      </div>
      <br>

      <div style="text-align:center">
          <span class="dot"></span>
          <span class="dot"></span>
          <span class="dot"></span>
      </div>
      <script type="text/javascript">
          var slideIndex = 0;
          showSlides();

          function showSlides() {
              var i;
              var slides = document.getElementsByClassName("mySlides");
              var dots = document.getElementsByClassName("dot");
              for (i = 0; i < slides.length; i++) {
                  slides[i].style.display = "none";
              }
              slideIndex++;
              if (slideIndex > slides.length) {slideIndex = 1}
              for (i = 0; i < dots.length; i++) {
                  dots[i].className = dots[i].className.replace(" active-Slide", "");
              }
              slides[slideIndex-1].style.display = "block";
              dots[slideIndex-1].className += " active-Slide";
              setTimeout(showSlides, 2000); //Allagi eikonas kathe 2 seconds
          }

      </script>
  </body>
</html>
