from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from database import engine, Base
from routes import products, cart, orders

# ──── Create all database tables ────
Base.metadata.create_all(bind=engine)

# ──── Create the FastAPI app ────
app = FastAPI(title="FreshMart API", version="1.0.0")

# ──── Allow Flutter to connect (CORS) ────
# Without this, Flutter gets "blocked by CORS policy" errors
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],       # Allow any device to connect
    allow_credentials=True,
    allow_methods=["*"],       # Allow GET, POST, PUT, DELETE
    allow_headers=["*"],       # Allow any headers
)

# ──── Register route files ────
app.include_router(products.router, prefix="/products", tags=["Products"])
app.include_router(cart.router, prefix="/cart", tags=["Cart"])
app.include_router(orders.router, prefix="/orders", tags=["Orders"])


# ──── Root endpoint — test if server is running ────
@app.get("/")
def root():
    return {"message": "FreshMart API is running"}


# ──── Seed sample data on startup ────
@app.on_event("startup")
def seed_data():
    from database import SessionLocal
    from models.product import Product
    from models.user import User

    db = SessionLocal()

    if db.query(Product).count() == 0:
        sample_products = [
            Product(
                name="Fresh Apples",
                description="Red organic apples, 1kg",
                price=3.99,
                stock=50,
                category="Fruits",
                image_url="https://images.pexels.com/photos/102104/pexels-photo-102104.jpeg"
            ),
            Product(
                name="Whole Milk",
                description="Full cream milk, 1 liter",
                price=1.49,
                stock=100,
                category="Dairy",
                image_url="https://images.pexels.com/photos/236010/pexels-photo-236010.jpeg"
            ),
            Product(
                name="Sourdough Bread",
                description="Freshly baked sourdough loaf",
                price=4.50,
                stock=30,
                category="Bakery",
                image_url="https://images.pexels.com/photos/1586947/pexels-photo-1586947.jpeg"
            ),
            Product(
                name="Chicken Breast",
                description="Boneless skinless, 500g",
                price=6.99,
                stock=40,
                category="Meat",
                image_url="https://images.pexels.com/photos/2338407/pexels-photo-2338407.jpeg"
            ),
            Product(
                name="Organic Eggs",
                description="Free-range, 12 pack",
                price=5.29,
                stock=60,
                category="Dairy",
                image_url="https://images.pexels.com/photos/162712/egg-white-food-protein-162712.jpeg"
            ),
            Product(
                name="Basmati Rice",
                description="Premium aged basmati, 2kg",
                price=7.99,
                stock=45,
                category="Grains",
                image_url="https://images.pexels.com/photos/4110251/pexels-photo-4110251.jpeg"
            ),
        ]
        db.add_all(sample_products)
        db.commit()
        print("✅ Sample products added")

    if db.query(User).count() == 0:
     sample_users = [
        User(
            name="Test Customer",
            email="customer@test.com",
            password="123456",
            role="customer",
            phone="01012345678",
            address="123 Main St, Cairo"
        ),
        User(
            name="Vendor User",
            email="vendor@test.com",
            password="vendor123",
            role="vendor",
            phone="01098765432",
            address="FreshMart Store"
        ),
    ]
    db.add_all(sample_users)
    db.commit()
    print("✅ Sample users added")

    db.close()