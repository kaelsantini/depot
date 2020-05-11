import React from 'react'

class PurchaseOrderType extends React.Component {

  render() {
    return (
      <div>
        <div className="field">
          <label htmlFor="order_po_number">P0 #</label>
          <input type="password" name="order[po_number]" id="order_po_number" />
        </div>
      </div>
    );
  }

}
export default PurchaseOrderType