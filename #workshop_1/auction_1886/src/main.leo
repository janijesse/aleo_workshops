program auction_1886.aleo {
  
    record Bid {
        owner: address,
        bidder: address,
        amount: u64,
        is_winner: bool,
    }

    record Prize {
        owner: address,
        amount: u64
    }

    transition place_bid(bidder: address, amount: u64) -> Bid {
        // Hardcoded address of the auctioneer
        let auction_owner: address = aleo1nyrhvut686c20vy06j2lgqfslnrt3zxcscxwhdvmxvh3tzwtcqqsq67xm3;
        
        assert_eq(self.caller, bidder);
        
        return Bid {
            owner: auction_owner, // The auctioneer owns the bid record
            bidder: bidder,
            amount: amount,
            is_winner: false,
        };
    }

    transition resolve(first: Bid, second: Bid) -> Bid {
        // Hardcoded address of the auctioneer
        let auction_owner: address = aleo1nyrhvut686c20vy06j2lgqfslnrt3zxcscxwhdvmxvh3tzwtcqqsq67xm3;

        assert_eq(self.caller, auction_owner);
       
        if (first.amount >= second.amount) {
            return first;
        } else {
            return second;
        }
    }

    transition finish(bid: Bid) -> Bid {
        // Hardcoded address of the auctioneer
        let auction_owner: address = aleo1nyrhvut686c20vy06j2lgqfslnrt3zxcscxwhdvmxvh3tzwtcqqsq67xm3;
   
        assert_eq(self.caller, auction_owner);
        
        return Bid {
            owner: bid.owner,
            bidder: bid.bidder,
            amount: bid.amount,
            is_winner: true,
        };
    }

    transition claim(bid: Bid) -> Prize {
       
        assert_eq(bid.is_winner, true);
        assert_eq(self.caller, bid.bidder);
   
        return Prize {
            owner: bid.bidder, 
            amount: bid.amount 
        };
    }
}
