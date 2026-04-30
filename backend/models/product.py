from sqlalchemy import Column, Integer, String, Float, ForeignKey
from sqlalchemy.orm import relationship
from database import Base


class Product(Base):
    __tablename__ = "products"

    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    name = Column(String, nullable=False)
    description = Column(String, nullable=True)
    price = Column(Float, nullable=False)
    stock = Column(Integer, nullable=False, default=0)
    category = Column(String, nullable=True)
    image_url = Column(String, nullable=True)

    #  link product to the vendor (User) who owns it
    vendor_id = Column(Integer, ForeignKey("users.id"), nullable=True)

    # Optional but useful: lets you do product.vendor.name in Python
    vendor = relationship("User", foreign_keys=[vendor_id])