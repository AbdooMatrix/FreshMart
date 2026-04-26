from fastapi import FastAPI
from database import engine, Base
from routes import products, cart, orders

Base.metadata.create_all(bind=engine)

app = FastAPI(title="FreshMart API")

app.include_router(products.router, prefix="/products", tags=["Products"])
app.include_router(cart.router, prefix="/cart", tags=["Cart"])
app.include_router(orders.router, prefix="/orders", tags=["Orders"])