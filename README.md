# milesplit

This is a project fro IE3425, Engineering Databases, at Northeastern University.
The project is a Python file connected via Flask to HTML pages stored in a 'root/templates' folder with static sources stored in a 'root/static' folder.
The Python File also connects via commandline and SQLite3 to a database file, allowing queries to be passed from an HTML GUI that return rendered webpages displaying information from the database.
As GitHub pages only supports static HTML pages, they are only viewable here:      https://tedyee114.github.io/milesplit/templates/index
As the whole project only runs locally, the source filepaths are designed primarily to run locally as well.
However, the code is duplicated (very messy, I know) so that if users scroll down, they reach a setion of the webpage which has webpage-specific static content filepaths so it appears correctly.
The duplicated code is managed by an if statement that detects whether the page is being viewed locally or via the web, but that condition is only evaluated on the local version, so it still appears twice in the web version.

There would be more features, bugs, and formatting added with additional  time, but this product was a proof-of concept that the whole process was doable.
