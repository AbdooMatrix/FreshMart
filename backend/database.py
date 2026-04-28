from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

# This creates a file called freshmart.db in the backend folder
SQLALCHEMY_DATABASE_URL = "sqlite:///./freshmart.db"

# Create the engine — this is the connection to the database
engine = create_engine(
    SQLALCHEMY_DATABASE_URL,
    connect_args={"check_same_thread": False}  # Required for SQLite
)

# Create a session factory — sessions are used to talk to the DB
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Base class — all models inherit from this
Base = declarative_base()


# This function gives a database session to each API endpoint
# It opens a connection, lets the endpoint use it, then closes it
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()