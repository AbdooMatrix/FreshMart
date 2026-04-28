from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from database import get_db
from schemas.product_schema import ProductCreate, ProductUpdate, ProductResponse
from crud import product_crud

router = APIRouter()


# GET /products — List all products
@router.get("", response_model=list[ProductResponse])
def list_products(db: Session = Depends(get_db)):
    return product_crud.get_all_products(db)


# GET /products/5 — Get product with ID 5
@router.get("/{product_id}", response_model=ProductResponse)
def get_product(product_id: int, db: Session = Depends(get_db)):
    product = product_crud.get_product_by_id(db, product_id)
    if not product:
        raise HTTPException(status_code=404, detail="Product not found")
    return product


# POST /products/add — Create a new product
@router.post("/add", response_model=ProductResponse, status_code=201)
def add_product(product: ProductCreate, db: Session = Depends(get_db)):
    return product_crud.create_product(db, product)


# PUT /products/5 — Update product with ID 5
@router.put("/{product_id}", response_model=ProductResponse)
def update_product(product_id: int, product: ProductUpdate, db: Session = Depends(get_db)):
    updated = product_crud.update_product(db, product_id, product)
    if not updated:
        raise HTTPException(status_code=404, detail="Product not found")
    return updated


# DELETE /products/5 — Delete product with ID 5
@router.delete("/{product_id}")
def delete_product(product_id: int, db: Session = Depends(get_db)):
    success = product_crud.delete_product(db, product_id)
    if not success:
        raise HTTPException(status_code=404, detail="Product not found")
    return {"message": "Product deleted successfully"}