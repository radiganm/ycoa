// @file     Entropy.groovy
// @author   Mac Radigan
// @version  $Id: Entropy.groovy 91 2012-06-10 06:55:21Z mac.radigan $

package org.radigan.ycoa.process.service

import java.util.LinkedHashMap
import java.util.List

public class Entropy {
  protected Map histogram = [:]
  protected double nats
  protected double NATS_TO_BITS = 1/Math.log(2.0D)

  public Entropy() {
  }

  public double getNats() {
    return nats
  }

  public double getBits() {
    return nats * NATS_TO_BITS
  }

  private void update() {
    nats = 0
    def sum = histogram.values().sum()
    histogram.each { symbol, cnt ->
      def probability = cnt / sum
      nats -= probability * Math.log(probability as double)
    }
  }

  public void addAll(List data) {
    data.each { symbol -> 
      if(!histogram[symbol]) histogram[symbol]=1 
      histogram[symbol]++ 
    }
    update()
  }

}

// *EOF*
