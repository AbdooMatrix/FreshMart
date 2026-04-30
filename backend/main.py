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

    # ──── Seed USERS first (products reference them via vendor_id) ────
    if db.query(User).count() == 0:
        sample_users = [
            User(
                # id = 1
                name="Test Customer",
                email="customer@test.com",
                password="123456",
                role="customer",
                phone="01012345678",
                address="Cairo, Egypt",
            ),
            User(
                # id = 2
                name="FreshMart Central Vendor",
                email="vendor1@test.com",
                password="vendor123",
                role="vendor",
                phone="01011111111",
                address="Cairo Market Center",
            ),
            User(
                # id = 3
                name="Green Valley Supplier",
                email="vendor2@test.com",
                password="vendor123",
                role="vendor",
                phone="01022222222",
                address="Giza Agricultural Hub",
            ),
            User(
                # id = 4
                name="Daily Harvest Store",
                email="vendor3@test.com",
                password="vendor123",
                role="vendor",
                phone="01033333333",
                address="Nasr City Branch",
            ),
            User(
                # id = 5
                name="Admin User",
                email="admin@test.com",
                password="admin123",
                role="admin",
                phone="01000000003",
                address="FreshMart HQ",
            ),
            User(
                # id = 6
                name="Ahmed Mahmoud",
                email="delivery@test.com",
                password="delivery123",
                role="delivery",
                phone="01000000004",
                address="On the road",
            ),
        ]
        db.add_all(sample_users)
        db.commit()
        print("✅ Sample users added")

    # ──── Seed PRODUCTS (each tied to a specific vendor) ────
    if db.query(Product).count() == 0:
        sample_products = [
            Product(
                name="Fresh Red Apples",
                description="Crisp organic apples freshly picked from local farms",
                price=3.49,
                stock=80,
                category="Fruits",
                image_url="https://images.pexels.com/photos/102104/pexels-photo-102104.jpeg",
                vendor_id=3,  # Green Valley Supplier
            ),
            Product(
                name="Farm Fresh Milk",
                description="Locally sourced whole milk",
                price=1.59,
                stock=120,
                category="Dairy",
                image_url="https://images.pexels.com/photos/236010/pexels-photo-236010.jpeg",
                vendor_id=2,  # FreshMart Central Vendor
            ),
            Product(
                name="Artisan Sourdough Bread",
                description="Stone-baked traditional sourdough loaf",
                price=4.99,
                stock=35,
                category="Bakery",
                image_url="https://images.pexels.com/photos/1586947/pexels-photo-1586947.jpeg",
                vendor_id=4,  # Daily Harvest Store
            ),
            Product(
                name="Fresh Chicken Breast",
                description="High-quality boneless chicken breast",
                price=6.79,
                stock=50,
                category="Meat",
                image_url="https://images.pexels.com/photos/2338407/pexels-photo-2338407.jpeg",
                vendor_id=2,  # FreshMart Central Vendor
            ),
            Product(
                name="Organic Free Range Eggs",
                description="Farm fresh 12-pack eggs",
                price=5.49,
                stock=75,
                category="Dairy",
                image_url="https://images.pexels.com/photos/162712/egg-white-food-protein-162712.jpeg",
                vendor_id=3,  # Green Valley Supplier
            ),
            Product(
                name="Premium Basmati Rice",
                description="Aged aromatic basmati rice 2kg pack",
                price=8.29,
                stock=60,
                category="Grains",
                image_url="https://images.pexels.com/photos/4110251/pexels-photo-4110251.jpeg",
                vendor_id=4,  # Daily Harvest Store
            ),
            Product(
                name="Fresh Tomatoes",
                description="Juicy vine-ripened tomatoes",
                price=2.19,
                stock=90,
                category="Vegetables",
                image_url="https://images.pexels.com/photos/533280/pexels-photo-533280.jpeg",
                vendor_id=3,  # Green Valley Supplier
            ),
            Product(
                name="Green Olives",
                description="Mediterranean cured green olives",
                price=3.99,
                stock=40,
                category="Grocery",
                image_url="https://images.pexels.com/photos/3023476/pexels-photo-3023476.jpeg",
                vendor_id=2,  # FreshMart Central Vendor
            ),
        ]
        db.add_all(sample_products)
        db.commit()
        print("✅ Sample products added")

    db.close()

    